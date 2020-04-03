class AdminController < ApplicationController
  before_action :admin_required

  def dashboard
  	@product_count = Product.all.count
  	@order_count = Order.all.count
    @user_count = User.all.count
    @locations = Gmaps4rails.build_markers(PaymentInfo.where.not(latitude: nil).where.not(latitude: nil).limit(100)) do |payinfo, marker|
      puts 'PaymentInfo -> lat_long is', payinfo.latitude, payinfo.longitude
      # next if state.nil?
      # c =  ISO3166::Country.new(paymentinfo.country)
      # c = Geocoder.search(state)
      # puts 'C is ', c.first.coordinates[0], c.first.coordinates[1]
      marker.lat payinfo.latitude
      marker.lng payinfo.longitude
    end
  end

end
