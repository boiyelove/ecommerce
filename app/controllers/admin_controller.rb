class AdminController < ApplicationController
  before_action :admin_required

  def dashboard
  	@product_count = Product.all.count
  	@order_count = Order.all.count
    @user_count = User.all.count
    @locations = Gmaps4rails.build_markers(PaymentInfo.paginate(page:1, per_page:100)) do |paymentinfo, marker|
      puts 'PaymentInfo -> country is', paymentinfo.state
      next if paymentinfo.state.nil?
      # c =  ISO3166::Country.new(paymentinfo.country)
      c = Geocoder.search(paymentinfo.state)
      puts 'C is ', c.first.coordinates[0], c.first.coordinates[1]
      marker.lat c.first.coordinates[0]
      marker.lng c.first.coordinates[1]
    end
  end

end
