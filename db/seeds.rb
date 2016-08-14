puts "BEGIN: Create Admin"
User.create(email: "admin@example.com", first_name: "John", last_name: "Doe", password: "password", password_confirmation: "password")
puts "END:   Create Admin"

puts "BEGIN: Creating Users"
users = []
(1..200).each do
  password = Faker::Internet.password(30, 60, true, true)
  users << {
    email: Faker::Internet.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: password,
    password_confirmation: password
  }
end
User.create(users)
puts "END:   Creating Users"

puts "BEGIN: Creating Events"
events = []
(1..200).each do
  events << { name: Faker::Company.catch_phrase, description: Faker::Lorem.sentences(1)[0] }
end
Event.create(events)
puts "END:   Creating Events"
