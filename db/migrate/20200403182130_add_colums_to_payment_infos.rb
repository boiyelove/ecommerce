class AddColumsToPaymentInfos < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_infos, :latitude,:string, null: true
    add_column :payment_infos, :longitude,:string, null: true
  end
end
