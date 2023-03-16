require_relative "../../lib/ngan_luong.rb"

NganLuong.configure do |config|
  config.checkout_url = ENV['NGAN_LUONG_CHECKOUT_URL']
  config.merchant_id = ENV['NGAN_LUONG_MERCHANT_ID']
  config.merchant_pass = ENV['NGAN_LUONG_MERCHANT_PASS']
  config.notification_email = ENV['NGAN_LUONG_NOTIFICATION_EMAIL']
end
