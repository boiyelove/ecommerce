class RemoveColumsFromOrderItems < ActiveRecord::Migration[6.0]
  def change

    remove_column :order_items, :product_id, :integer

    remove_column :order_items, :cart_id, :integer

    remove_column :order_items, :order_id, :integer
  end
end
