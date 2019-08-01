# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Proprietor.destroy_all
Home.destroy_all

(1..10).to_a.each do |i|
  puts "Creating User #{i}"
  email = Faker::Internet.email
  password = 'password'
  User.create!(email: email, password: password)

  puts "Creating Proprietor #{i}"
  name = Faker::Name.name
  user_id = i
  Proprietor.create!(name: name, user_id: user_id)

  puts "Creating Home #{i}"
  name = Faker::Name.name
  proprietor_id = i
  Home.create!(name: name, proprietor_id: proprietor_id)
end

p "Created #{User.count} User"
p "Created #{Proprietor.count} User"
p "Created #{Home.count} User"
