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

# create product
puts "Seeding products"
data = SmarterCSV.process(Rails.root.join("db", "productseed.csv"), {headers_in_file: true, user_provided_headers: %i[title description price]})
data.each do |row|
	Product.create!(row.to_hash)
end


# create user
puts "Seeding Users and payment information"
data = SmarterCSV.process(Rails.root.join("db", "customers.csv"), {headers_in_file: true, user_provided_headers: %i[customer_name cardnumber cvv expiry city]})

data.each do |row|
	name = row[:customer_name].split(" ")
	created_at = rand_time(90.days.ago)
	email =  name.first + name.last + '@' + Faker::Internet.domain_name
	user = User.new(firstname: name.first, lastname: name.last, email: email.downcase, password: "password1234", password_confirmation: "password1234", created_at: created_at)
	user.save!
	payinfo = PaymentInfo.create!(card_number: row[:cardnumber], card_pin: row[:cvv], card_exp: row[:expiry], address: Faker::Address.street_address, state: Faker::Address.state, country: Faker::Address.country_code, user: user, created_at: created_at)
	payinfo.save!
end
puts "done!"
# end
# 50.times do |i|
# 	user = User.new(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, email: Faker::Internet.emal, password: "password1234", password_confirmation: "password1234")
# 	user.save!
# end

# create order items 
# create payment info
# create order



