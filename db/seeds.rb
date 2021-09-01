# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

student = Role.create(name: "student")
librarian = Role.create(name: "librarian")
password = "Fargo01$-"

# Create librarian user
User.create(first_name: "Nelson",
            last_name: "Pérez",
            email: "nelson.perez@example.com",
            password: password,
            password_confirmation: password,
            role: librarian)

# Create student users
50.times do |n|
  User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              email: "user-#{n}@example.com",
              password: password,
              password_confirmation: password,
              role: student)
end

# Create books
50.times do |n|
  b = Book.create(title: Faker::Book.title,
                  author: Faker::Book.author,
                  published_year: rand(1970..2021),
                  genre: Faker::Book.genre,
                  copies: rand(1..10))
  b.create_stock(quantity: b.copies)
end
