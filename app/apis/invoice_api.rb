require 'paypal-sdk-rest'
require 'paypal-sdk-invoice'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging

class InvoiceApi

  def initialize
    @api = PayPal::SDK::Invoice::API.new(
      :mode      => "sandbox",
      :app_id    => ENV['APP_ID'],
      :username  => ENV['USERNAME'],
      :password  => ENV['PASSWORD'],
      :signature => ENV['SIGNATURE'])
  end

  def build_create_and_send_invoice(email, event_name, unit_price)
    @api.build_create_and_send_invoice({
      :invoice => {
        :merchantEmail => ENV['MERCHANT_EMAIL'],
        :payerEmail => email,
        :itemList => {
            :item => [{ "name": event_name,
                        "quantity": "1",
                        "unitPrice": unit_price
                      }]
                      },
        :currencyCode => "USD",
        :paymentTerms => "DueOnReceipt" } })
  end

  def create_and_send_invoice(invoice)
    @api.create_and_send_invoice(invoice)
  end
end
