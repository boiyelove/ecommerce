class RemoveColumnFromProduct < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :permalink, :string
  end
end
