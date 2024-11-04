# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  email: "user1@yopmail.com",
  encrypted_password: "password1",
  description: "First user description",
  first_name: "Jose",
  last_name: "Doe"
)

User.create!(
  email: "user2@yopmail.com",
  encrypted_password: "password2",
  description: "Second user description",
  first_name: "Josiane",
  last_name: "Doe"
)
Event.create!(
  start_date: Time.now + 1.day,
  duration: 60,
  title: "Sample Event",
  description: "This is a sample event with a valid description length.",
  price: 100,
  location: "Rennes",
  admin: User.first
)