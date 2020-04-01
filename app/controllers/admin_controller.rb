class AdminController < ApplicationController
  before_action :is_admin

  def dashboard
  	@product_count = Product.all.count
  	@order_count = Order.all.count
    @user_count = User.all.count
    @locations = Gmaps4rails.build_markers(PaymentInfo.paginate(page:1, per_page:100)) do |paymentinfo, marker|
      puts 'PaymentInfo -> country is', paymentinfo.country
      next if paymentinfo.country.nil?
      c =  ISO3166::Country.new(paymentinfo.country)
      puts 'C is ', c
      marker.lat c.latitude_dec
      marker.lng c.longitude_dec
    end
  end


  def is_admin
    unless is_user_admin?
    # if user is not logged in raise 404
    # if user is logged in and user is not admin raise 404
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end

  end

end
