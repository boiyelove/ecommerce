# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# require 'faker'


# Faker::Name.name
# Faker::Internet.email
# def genprice
# 	rand * (500-1) + 1
# end

# Helpers
def rand_time(from, to=Time.now)
  Time.at(rand_in_range(from.to_f, to.to_f))
end

def rand_in_range(from, to)
  rand * (to - from) + from
end

# #create product
# puts "Seeding products"
# data = SmarterCSV.process(Rails.root.join("db", "productseed.csv"), {headers_in_file: true, user_provided_headers: %i[title description price]})
# data.each do |row|
# 	Product.create!(row.to_hash)
# end


# # create user
# puts "Seeding Users and payment information"
# data = SmarterCSV.process(Rails.root.join("db", "customers.csv"), {headers_in_file: true, user_provided_headers: %i[customer_name cardnumber cvv expiry city]})

# data.each do |row|
# 	name = row[:customer_name].split(" ")
# 	created_at = rand_time(90.days.ago)
# 	email =  name.first + name.last + '@' + Faker::Internet.domain_name
# 	user = User.new(firstname: name.first, lastname: name.last, email: email.downcase, password: "password1234", password_confirmation: "password1234", created_at: created_at)
# 	user.save!
# 	payinfo = PaymentInfo.create!(card_number: row[:cardnumber], card_pin: row[:cvv], card_exp: row[:expiry], address: Faker::Address.street_address, state: Faker::Address.state, country: Faker::Address.country_code, user: user, created_at: created_at)
# 	payinfo.save!
# end


# puts "Seeding Orders"
# users = User.all
# users.each do |user|
# 	order = Order.new
# 		10.times do |i|
# 			order_item = OrderItem.new
# 			product = Product.find(rand_in_range(1, Product.all.count))
# 			order_item.product = product
# 			order_item.quantity = rand_in_range(1, 10)
# 			order_item.save!
# 			order.order_items << order_item
# 		end
# 	order.user = user
# 	payinfo = PaymentInfo.find_by(user_id: user.id)
# 	order.payment_info_id = payinfo.id
# 	order.created_at = rand_time(60.days.ago)
# 	order.save!
# end


puts "Seeding Latitude and Longitude"
payinfos = PaymentInfo.where(latitude: nil).where.not(state: [nil, ""])
payinfos.each do |payinfo|
	 state = Geocoder.search(payinfo.state)
	 # puts '"#{payinfo.state} is #{state.first.coordinates[0], state.first.coordinates[1]}"'
	 if !state.nil?
		 payinfo.latitude = state.first.coordinates[0]
		 payinfo.longitude = state.first.coordinates[1]
		 payinfo.save!
end

puts "done!"


