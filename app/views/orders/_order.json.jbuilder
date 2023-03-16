json.extract! order, :id, :name, :phone_number, :shipping_address, :quantity, :bank_account_number, :bank_name, :created_at, :updated_at
json.url order_url(order, format: :json)
