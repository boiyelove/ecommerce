class CartController < ApplicationController
  before_action :current_cart, only: [:checkout, :show, :destroy]

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
    @user = User.new if !logged_in?
    @payinfo = PaymentInfo.find_by_user_id(@current_user.id) if logged_in?
    @payinfo ||= PaymentInfo.new
    session[:welcome_path] = cart_path if !logged_in?
    if logged_in? && params[:checkout]
      payinfo = PaymentInfo.find_by_user_id(@current_user.id)
      if payinfo.card_number != @payinfo.card_number
        #store payment information
        # @payinfo.card_number = payment_params[:card_number]
        # @payinfo.card_exp = payment_params[:card_exp]
        # @payinfo.card_pin = payment_params[:card_pin]
        # @payinfo.address = payment_params[:address]
        # @payinfo.state = payment_params[:state]
        # @payinfo.country = payment_params[:country]
        @payinfo.create(payment_params, user_id: @current_user.id)
        # # @payinfo(payment_params)
        # @payinfo.user = @current_user
        # @payinfo.save
      end
      #create order
      if @payinfo.persisted?
        @order = Order.new
        @current_cart.order_items.each do |item|
          @order.order_items << item
          item.cart_id = nil
        end
      
        @order.user = @current_user
        @order.payment_info_id = @payinfo.id
        @order.save!
        if @order.persisted?
          Cart.destroy(session[:cart_id])
          session[:cart_id] = nil
          redirect_to root_path, notice: "Your order has completed successfully"
        end
      end
    end
  end

  def destroy
  	@cart = @current_cart
  	@cart.destroy
  	session[:cart_id] = nil
  	redirect_to root_path
  end
  private
    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment_info).permit(:address, :state, :country, :card_number, :card_pin, :card_ccv)
    end
end
