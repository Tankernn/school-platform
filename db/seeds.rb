# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Example User",
             login: "example",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             birth_date: 15.years.ago,
             phone:      "(333) 333-3333")


99.times do |n|
 name  = Faker::Name.name
 email = "example-#{n+1}@example.com"
 password = "password"
 login = "example_#{n+1}"
 birth_date = Faker::Date.between(15.years.ago, 70.years.ago)
 phone = Faker::PhoneNumber.cell_phone
 User.create!(name:  name,
              email: email,
              login: login,
              password:              password,
              password_confirmation: password,
              birth_date: birth_date,
              phone:      phone)
end
