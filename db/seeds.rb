# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
puts "Seeding data to the datbase......"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?



Client.destroy_all

#  10.times do
#   @client = Client.create!(
#     name: Faker::Name.unique.name_with_middle,
#     address: Faker::Address.unique.street_address,
#     company: Faker::Company.unique.name,
#     phone_number: Faker::PhoneNumber.unique.cell_phone_with_country_code,
#   ) 
# end

 puts "Seeding Operation Complete !"