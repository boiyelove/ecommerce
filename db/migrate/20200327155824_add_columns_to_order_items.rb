class AddColumnsToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :cart_id, :integer
    add_column :order_items, :order_id, :integer
  end
end
