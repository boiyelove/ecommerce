class AdminController < ApplicationController
  before_action :admin_required

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

end
