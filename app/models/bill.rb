require 'paypal-sdk-invoice'
require 'paypal-sdk-rest'
require 'paypal-sdk-merchant'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging
include ActionController::HttpAuthentication::Token::ControllerMethods

class Bill < ApplicationRecord

  belongs_to :event
  belongs_to :user

  validates :event_id, :user_id, :bill_type, :amount, presence: true

  # def get_bill_details
  #   self.bill_type == 'debit' ? self.get_invoice_details : self.get_payout_info
  # end

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
        # p @get_invoice_details_response
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
