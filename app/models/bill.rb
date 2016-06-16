require 'paypal-sdk-invoice'
require 'paypal-sdk-rest'
require 'paypal-sdk-merchant'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging
require 'paypal_module.rb'

class Bill < ApplicationRecord
  include Paypal

  belongs_to :event
  belongs_to :user

  validates :event, :user, :bill_type, :amount, presence: true

  def paypalurl
    "https://www.sandbox.paypal.com/us/cgi-bin/?cmd=_pay-inv&id=#{self.paypal_id}" if self.bill_type == 'debit'
  end

  def groupname
    self.event.group.name
  end


end
