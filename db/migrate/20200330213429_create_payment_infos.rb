class CreatePaymentInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_infos do |t|
      t.integer :card_number
      t.string :card_exp
      t.integer :card_pin
      t.references :user, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :address
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
