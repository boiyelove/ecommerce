class AddReferencesToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :order_items, :product, null: false, foreign_key: true, default:1
    add_reference :order_items, :cart, null: false, foreign_key: true, default:1
    add_reference :order_items, :order, null: false, foreign_key: true, default:1
  end
end
