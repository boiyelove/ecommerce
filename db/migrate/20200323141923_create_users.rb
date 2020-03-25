class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :firstame
      t.string :lastname
      t.string :email
      t.boolean :isadmin

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
