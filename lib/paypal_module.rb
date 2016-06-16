module Paypal

  # generate bill objects in the database
  def generate_invoices
    get_member_balances.each do |bill|
      # Get user
      @user = User.find_by(email: bill[0])
      # Get bill type
      bill_type = nil
      if bill[1] == 0
        # If the user paid exactly their fair share...create a bill for them with amount 0
        return @new_bill = Bill.find_or_create_by(event_id: id, user_id: @user.id, bill_type: 'debit', amount: 0.round(2), satisfied?: true)
      elsif bill[1] > 0
        bill_type = 'credit'
      elsif bill[1] < 0
        bill_type = 'debit'
      end

      # create bill object
      @new_bill = Bill.find_by(event_id: id, user_id: @user.id, bill_type: bill_type, amount: bill[1].round(2))

      # for the users that owe money, create an invoice using PayPal API
      if @new_bill.nil? # prevent duplicate paypal invoices
        @new_bill = Bill.create(event_id: id, user_id: @user.id, bill_type: bill_type, amount: bill[1].round(2))
        if bill_type == 'debit'
          event_name = name
          email = @user.email
          unit_price = (@new_bill.amount * (-1))

          # Set up PayPal client
          @api = PayPal::SDK::Invoice::API.new(
            :mode      => "sandbox",
            :app_id    => ENV['APP_ID'],
            :username  => ENV['USERNAME'],
            :password  => ENV['PASSWORD'],
            :signature => ENV['SIGNATURE'])

          # Build request object
          @create_and_send_invoice = @api.build_create_and_send_invoice({
            :invoice => {
              :merchantEmail => ENV['MERCHANT_EMAIL'],
              :payerEmail => email,
              :itemList => {
                  :item => [{ "name": event_name,
                              "quantity": "1",
                              "unitPrice": @new_bill.amount * (-1)
                            }]
                            },
              :currencyCode => "USD",
              :paymentTerms => "DueOnReceipt" } })

          # Make API call & get response
          @create_and_send_invoice_response = @api.create_and_send_invoice(@create_and_send_invoice)

          # Access Response
          if @create_and_send_invoice_response.success?
            @new_bill.update_attribute(:paypal_id, @create_and_send_invoice_response.invoiceID)
            @new_bill.save
            send_email(@new_bill.paypal_id, email)

            # p @create_and_send_invoice_response
            # @create_and_send_invoice_response.invoiceID
            # @create_and_send_invoice_response.invoiceNumber
            # @create_and_send_invoice_response.invoiceURL
            # @create_and_send_invoice_response.totalAmount
          else
            @create_and_send_invoice_response.error
          end # close response loop
        end # close API call
      end # close IF loop
    end # close create bill loop
  end # close generate_invoices method

  # Payout the creditors
  def payout
    bills.each do |bill|
      if bill.bill_type == 'credit' && bill.satisfied? == false
        creditor = User.find(bill.user_id)
        email = creditor.email

        # Set up PayPal client
        @api = PayPal::SDK::REST.set_config(
              :mode => "sandbox",
              :client_id => ENV['CLIENT_ID'],
              :client_secret => ENV['CLIENT_SECRET'])

        # Build request object
        @payout = Payout.new(
            {
              :sender_batch_header => {
                :sender_batch_id => SecureRandom.hex(8),
                :email_subject => 'You have a Payout!',
              },
              :items => [
                {
                  :recipient_type => 'EMAIL',
                  :amount => {
                    :value => bill.amount,
                    :currency => 'USD'
                  },
                  :note => 'Thanks for your patronage!',
                  :receiver => email,
                  :sender_item_id => "2014031401013",
                }]})

        # Create Payment and return the status (true/false)
        if @payout.create
          bill.update_attributes(:satisfied? => true, :paypal_id => "123")
          settle_event
        else
          @payout.error  # Error Hash
        end # Close if/else status
      end # Close if bill.bill_type = 'credit' loop
    end # Close bills.each loop
  end # Close payout method

  def get_invoice_details
    if self.bill_type == 'debit'

      # Set up paypal client
      @api = PayPal::SDK::Invoice::API.new(
            :mode      => "sandbox",
            :app_id    => ENV['APP_ID'],
            :username  => ENV['USERNAME'],
            :password  => ENV['PASSWORD'],
            :signature => ENV['SIGNATURE'])

      # Build request object
      @get_invoice_details = @api.build_get_invoice_details({
        :invoiceID => self.paypal_id })

      # Make API call & get response
      @get_invoice_details_response = @api.get_invoice_details(@get_invoice_details)

      # Access Response
      if @get_invoice_details_response.success?
        if @get_invoice_details_response.paymentDetails.paypalPayment.amount == self.amount * (-1)
          self.update_attribute(:satisfied?, true)
          self.save
          # p @get_invoice_details_response
          # @get_invoice_details_response.invoice
          # @get_invoice_details_response.invoiceDetails
          # @get_invoice_details_response.refundDetails
          # @get_invoice_details_response.invoiceURL
        end
      else
        @get_invoice_details_response.error
      end
    end
  end

  # def get_payout_info
  #   # Set up paypal client
  #   PayPal::SDK.configure(
  #     :mode      => "sandbox",
  #     :app_id    => ENV['APP_ID'],
  #     :username  => ENV['USERNAME'],
  #     :password  => ENV['PASSWORD'],
  #     :signature => ENV['SIGNATURE'])

  #   @api = PayPal::SDK::Merchant.new

  #   @get_transaction_details = @api.build_get_transaction_details({
  #     :TransactionID => "34R12287F3017233P" }) # self.paypal_id

  #   # Make API call & get response
  #   @get_transaction_details_response = @api.get_transaction_details(@get_transaction_details)

  #   # Access Response
  #   if @get_transaction_details_response.success?
  #     @get_transaction_details_response.PaymentTransactionDetails.PaymentInfo
  #     # @get_transaction_details_response.PaymentTransactionDetails
  #     # @get_transaction_details_response.ThreeDSecureDetails
  #   else
  #     @get_transaction_details_response.Errors
  #   end
  # end

end