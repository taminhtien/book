class Order < ApplicationRecord
  validates :name, presence: true
  validates :phone_number, presence: true
  validates :shipping_address, presence: true
  validates :quantity, presence: true
  validates :bank_account_number, presence: true
  validates :bank_name, presence: true
  validates :code, presence: true

  before_validation :set_code, on: :create

  enum payment_status: { pending: 0, processing: 1, cancelled: 2, paid: 3 }

  def price
    quantity * 1000
  end

  def currency
    'vnd'
  end

  def tax
    0
  end

  def discount
    0
  end

  def fee_cal
    0
  end

  def fee_shipping
    0
  end

  def buyer_info
    [name, phone_number].join(" - ")
  end

  def description
    "The Khải Huyền - Số lượng: #{quantity}"
  end

  private

  def set_code
    self.code = SecureRandom.uuid
  end
end
