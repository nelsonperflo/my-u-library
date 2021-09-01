# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

student = Role.create(name: "student")
librarian = Role.create(name: "librarian")

User.create(first_name:  "Nelson",
            last_name: "Pérez",
            email: "nelson.perez@example.com",
            password:              "Fargo01$-",
            password_confirmation: "Fargo01$-",
            role: librarian)

50.times do |n|
  User.create(first_name:  "User #{n}",
              last_name: "Example #{n}",
              email: "user-#{n}@example.com",
              password:              "Fargo01$-",
              password_confirmation: "Fargo01$-",
              role: student)
end

50.times do |n|
  Book.create(title:  "Title #{n}",
              author: "Author #{n}",
              published_year: rand(1970..2021),
              genre: ["Crime", "Mistery", "Science fiction", "Thriller"].sample)
end
