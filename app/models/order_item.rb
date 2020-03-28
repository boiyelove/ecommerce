class OrderItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product
	belongs_to :order


	def total_price
		self.quantity * self.product.price
    end

end
