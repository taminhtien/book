require 'ngan_luong/payment'

module NganLuong
  extend Dry::Configurable

  setting :checkout_url
  setting :merchant_id
  setting :merchant_pass
  setting :notification_email
end
