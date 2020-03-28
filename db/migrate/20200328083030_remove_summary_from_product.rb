class RemoveSummaryFromProduct < ActiveRecord::Migration[6.0]
  def change

    remove_column :products, :summary, :string
  end
end
