class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.string :phone_number
      t.string :shipping_address
      t.integer :quantity
      t.string :bank_account_number
      t.string :bank_name

      t.timestamps
    end
  end
end
