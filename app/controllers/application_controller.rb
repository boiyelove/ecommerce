class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
  helper_method :is_user_admin?, :logged_in?, :current_user
  before_action :current_user
  # before_action :only_admin, only: [:edit, :update, :destroy]


	# private
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
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404 unless (logged_in? and is_user_admin?)
    end


    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def is_user_admin?
      !!User.exists?(id: session[:user_id], is_admin: true) 
    end

  # def auth_user
  #   puts 'logged in is', logged_in?
  #   redirect_to login_path, notice: "Please login to continue" if !logged_in?
  # end
  # def current_cart
  # 	if session[:cart]
  # 		@current_cart ||= session[:cart]
  # 	else
  # 		session[:cart] = Hash.new
  # 		@current_cart ||= session[:cart]
  # 	end
end
