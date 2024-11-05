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

User.destroy_all
Event.destroy_all

admin_user = User.create!(
  email: Faker::Internet.unique.email,
  password: Faker::Internet.password(min_length: 6),
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name
)


5.times do
  Event.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 5),
    location: Faker::Address.city,
    start_date: Faker::Time.forward(days: 23, period: :evening),
    duration: [30, 60, 90, 120].sample,
    price: rand(1..500),
    admin: admin_user 
  )
end

5.times do
  User.create!(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: 'password123'
  )
end