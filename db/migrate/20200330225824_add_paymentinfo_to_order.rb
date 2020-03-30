class AddPaymentinfoToOrder < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :payment_info, null: true, foreign_key: true
  end
end
