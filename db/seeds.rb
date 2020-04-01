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

# create product
data = SmarterCSV.process(Rails.root.join("db", "productseed.csv"), {headers_in_file: true, user_provided_headers: %i[title description price]})
data.each do |row|
	Product.create!(row.to_hash)
end



