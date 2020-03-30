class RemoveOrderFromPaymentInfo < ActiveRecord::Migration[6.0]
  def change
    remove_reference :payment_infos, :order, null: true, foreign_key: true
  end
end
