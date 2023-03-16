module NganLuong
  class Payment
    class << self
      def config
        NganLuong.config
      end

      def get_checkout_url(order_code:, price:, currency:, quantity:, tax:, discount:, fee_cal:, fee_shipping:, cancel_url:, return_url:, notify_url:, order_description: nil, transaction_info: nil, buyer_info: nil, affiliate_code: nil, lang: nil, time_limit: nil)
        merchant_site_code = config.merchant_id
        receiver = config.notification_email
        secure_pass = config.merchant_pass
        secure_code = [merchant_site_code, return_url, receiver, transaction_info, order_code, price, currency, quantity, tax, discount, fee_cal, fee_shipping, order_description, buyer_info, affiliate_code, secure_pass].join(' ')
        hashed_secure_code = Digest::MD5.hexdigest(secure_code)

        params = {
          merchant_site_code: merchant_site_code,
          return_url: return_url,
          receiver: receiver,
          transaction_info: transaction_info,
          order_code: order_code,
          price: price,
          currency: currency,
          quantity: quantity,
          tax: tax,
          discount: discount,
          fee_cal: fee_cal,
          fee_shipping: fee_shipping,
          order_description: order_description,
          buyer_info: buyer_info,
          affiliate_code: affiliate_code,
          lang: lang,
          secure_code: hashed_secure_code,
          cancel_url: cancel_url,
          notify_url: notify_url,
        }

        "#{config.checkout_url}?#{params.to_query}"
      end
    end
  end
end
