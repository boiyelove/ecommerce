class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	before_action :current_cart
  before_action :only_admin, only: [:edit, :update, :destroy]
  helper_method :current_user, :is_user_admin?

  # def admin_scope?
  #   params[:admin_scope].eql? true
  # end

	private
		def current_cart
			if session[:cart_id]
				cart = Cart.find_by(:id => session[:cart_id])
        if cart.present?
          @current_cart = cart
        else
          session[:cart_id] = nil
        end
      end

      if session[:cart_id] == nil
        @current_cart = Cart.create
        session[:cart_id] = @current_cart.id
      end
    end

    # def current_cart
    #   if session[:cart].present?
    #     @current_cart = cart
    #   else

    #     session[:cart] = Hash.new
    #   end
    # end

    def only_admin
      # render file: "#{Rails.root}/public/404.html", layout: false, status: 404 if session['user_id'].nil? or (session['user_id'].present? && session['user_id'].is_admin?)
      puts "I say render by force naw!"
    end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def is_user_admin?
    User.exists?(id: session[:user_id], is_admin: true)
  end

 
  # def current_cart
  # 	if session[:cart]
  # 		@current_cart ||= session[:cart]
  # 	else
  # 		session[:cart] = Hash.new
  # 		@current_cart ||= session[:cart]
  # 	end
end
