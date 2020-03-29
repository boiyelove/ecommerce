class AdminController < ApplicationController
  before_Action :is_admin
  def dashboard
  end

  def products
  	@products = ProductController::index::products
  	# @products = Product.all
  	# render file: "admin/admin_products.html", layout: false, status: 404
  end

  def is_admin
    unless @current_user.is_admin
    # if user is not logged in raise 404
    # if user is logged in and user is not admin raise 404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

  end

end
