class Product < ApplicationRecord
	has_and_belongs_to_many :order_items
	has_one_attached :image
	
end
