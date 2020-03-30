class CartController < ApplicationController

  def add_to_cart(product_id)
  	# product = products.find(product_id)
  	# if product
  	# 	if current_cart.include?(product.id)
  	# 		current_cart[product.id] = current_cart.fetch(product.id) + 1
  	# 	end 
  	# 	# else
  	# 	# current
  	# end

  end

  def remove_from_cart
  end

  def show
  	@cart = @current_cart
  end

  def checkout
    @cart = @current_cart
    @countries = ISO3166::Country.all
  end

  def destroy
  	@cart = @current_cart
  	@cart.destroy
  	session[:cart_id] = nil
  	redirect_to root_path
  end
end
