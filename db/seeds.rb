# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

school = School.create!(name: "Fakeville High")

user = User.create!(name:  "Example User",
             login: "example",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar",
             birth_date: 15.years.ago,
             phone:      "(333) 333-3333",
             school: school,
             admin: true)

school.administrators << user
school.save


10.times do |n|
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
              phone:      phone,
              school: school)
end

conversation = Conversation.create!(name: "Important conversation")

ConversationParticipation.create!(conversation: conversation, user: user)

10.times do |n|
  content = Faker::Lorem.sentence(10)
  Message.create!(user: user, conversation: conversation, content: content)
end

10.times do |n|
  name = Faker::Educator.course
  course = Course.create!(school: school, name: name, starts_on: DateTime.now, ends_on: 6.months.since)
  CourseParticipation.create!(course: course, user: user, role: :teacher)
  CourseParticipation.create!(course: course, user: User.find(2), role: :student)
end

10.times do |n|
  description = Faker::Lorem.sentence(10)
  location = Faker::Address.street_address
  course = Course.find(1)
  start_at = (n + 1).hours.ago
  end_at = n.hours.ago
  Lecture.create(course: course, description: description, location: location, starts_at: start_at, ends_at: end_at)
end

10.times do |n|
  description = Faker::Lorem.paragraph
  name = Faker::Lorem.sentence(2)
  course = Course.find(Faker::Number.between(1, 10))
  due_at = Faker::Number.between(1, 10).days.since
  Assignment.create(course: course, name: name, description: description, due_at: due_at)
end

5.times do |n|
  name = Faker::Lorem.sentence(4)
  content = Faker::Lorem.paragraph
  course = Course.find(1)
  NewsPost.create(user: user, content: content, name: name, news_feed: course)
end
