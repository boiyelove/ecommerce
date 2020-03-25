class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :permalink
      t.string :summary
      t.decimal :price, precision: 10, scale: 2
      t.string :image
      t.text :description

      t.timestamps
    end
    add_index :products, :permalink, unique: true
  end
end
