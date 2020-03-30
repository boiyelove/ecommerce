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
    if session[:user_id].nil?
      @user = User.new
    end
    @payinfo = PaymentInfo.new
    if session[:user_id].nil?
      session[:welcome_path] = cart_path
    end
    if session[:user_id].present?
      user = User.find(session[:user_id])

      #store payment information
      @payinfo.card_number = params[:card_number]
      @payinfo.card_exp = params[:card_exp]
      @payinfo.card_pin = params[:card_pin]
      @payinfo.address = params[:address]
      @payinfo.state = params[:state]
      @payinfo.country = params[:country]

      @payinfo.user = user
      @payinfo.save!

      #create order
      @order = Order.new
      @current_cart.order_items.each do |item|
        @order.order_items << item
        item.cart_id = nil
      end
      
      @order.user = user
      @order.payment_info_id = @payinfo.id
      @order.save!
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil

      redirect_to root_path, notice: "Your order has completed successfully"
    end
  end

  def destroy
  	@cart = @current_cart
  	@cart.destroy
  	session[:cart_id] = nil
  	redirect_to root_path
  end
  # private
  #   # Only allow a list of trusted parameters through.
  #   def payment_params
  #     params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  #   end
end
