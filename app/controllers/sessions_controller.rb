class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
      if session[:welcome_path].present?
        destinationpath = session[:welcome_path]
        session[:welcome_path] = nil
        redirect_to destinationpath, notice: "You are now logged in"
  		end
      redirect_to root_url, notice: "Logged in!"
  	else
  		flash[:alert] = "Email or password is invalid"
      redirect_to login_path
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_url, notice: "Logged Out"
  end
end
