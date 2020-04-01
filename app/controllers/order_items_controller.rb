class OrderItemsController < ApplicationController
  before_action :set_order_item, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:edit, :update, :destroy]
  
  # GET /order_items
  # GET /order_items.json
  def index
    @order_items = OrderItem.all
  end

  # GET /order_items/1
  # GET /order_items/1.json
  # def show
  # end

  # GET /order_items/new
  def new
    @order_item = OrderItem.new
  end

  # GET /order_items/1/edit
  def edit
  end

  def add_quantity
    @order_item = OrderItem.find(params[:id])
    @order_item.quantity += 1
    @order_item.save!
    redirect_to cart_path
  end

  def reduce_quantity
    @order_item = OrderItem.find(params[:id])
    if @order_item.quantity > 1
      @order_item.quantity -= 1
    end
    @order_item.save
    redirect_to cart_path
  end
  # POST /order_items
  # POST /order_items.json
  def create
    selected_product = Product.find(params[:product_id])
    current_cart = @current_cart
    # puts current_cart.products
    if current_cart.products.include?(selected_product)
      @order_item = current_cart.order_items.find_by(:product_id => selected_product)
      @order_item.quantity += 1
      # puts "this old order item is #{@order_item}"
      @order_item.save
    else
      @order_item = OrderItem.create!(cart: current_cart, quantity: 1, product: selected_product )
      # @order_item.cart = current_cart
      # @order_item.quantity = 1
      # @order_item.product = selected_product
      # puts "this new order item is #{@order_item}"
      # puts "this new id order item is #{@order_item.id}"
    end
    
    # puts "current_cart is #{@current_cart}"
    # puts "current_cart is #{@current_cart.id}"
    # puts "its items are #{@current_cart.order_items}"
    redirect_to cart_path
    # @order_item = OrderItem.new(order_item_params)

    # respond_to do |format|
    #   if @order_item.save
    #     format.html { redirect_to @order_item, notice: 'Order item was successfully created.' }
    #     format.json { render :show, status: :created, location: @order_item }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @order_item.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /order_items/1
  # PATCH/PUT /order_items/1.json
  # def update
  #   respond_to do |format|
  #     if @order_item.update(order_item_params)
  #       format.html { redirect_to @order_item, notice: 'Order item was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @order_item }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @order_item.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /order_items/1
  # DELETE /order_items/1.json
  def destroy
    # @order_item.destroy
    # respond_to do |format|
    #   format.html { redirect_to order_items_url, notice: 'Order item was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
      @order_item = OrderItem .find(params[:id])
      @order_item.destroy
      redirect_to cart_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_item_params
      params.require(:order_item).permit(:product_id, :quantity, :cart_id)
    end
end
