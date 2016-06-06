require 'paypal-sdk-invoice'
require 'paypal-sdk-rest'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging
class Bill < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, :user_id, :bill_type, :amount, presence: true

  def get_invoice_details
    @api = PayPal::SDK::Invoice::API.new(
          :mode      => "sandbox",
          :app_id    => ENV['APP_ID'],
          :username  => ENV['USERNAME'],
          :password  => ENV['PASSWORD'],
          :signature => ENV['SIGNATURE'])

    # Build request object
    @get_invoice_details = @api.build_get_invoice_details({
      :invoiceID => self.paypal_id }) #"INV2-88A8-UXGK-LRNR-WEA9" })

    # Make API call & get response
    @get_invoice_details_response = @api.get_invoice_details(@get_invoice_details)

    # Access Response
    if @get_invoice_details_response.success?
      # p @get_invoice_details_response
      p @get_invoice_details_response.paymentDetails.paypalPayment.amount
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


#   @invoice= Invoice.find("INV2-P6VJ-36HG-BBVT-M2MA")
#   logger.info "Got Invoice Details for Invoice[#{@invoice.id}]"

# rescue ResourceNotFound => err
#   logger.error "Invoice Not Found"
# end