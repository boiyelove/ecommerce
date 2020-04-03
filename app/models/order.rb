class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  
	def sub_total
		sum = 0
		self.order_items.each do|order_item|
			sum+= order_item.total_price
		end
		return sum
	end

	def total_quantity
		sum = 0
		self.order_items.each do|order_item|
			sum += order_item.quantity
		end
		return sum
	end
end
