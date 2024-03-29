puts "BEGIN: Create Admin"
User.create(email: "admin@example.com", first_name: "John", last_name: "Doe", password: "{,xF24V^tbupd6yjW*X,492[NRdhXJLz}PbE29]$JPn34cVN)o", password_confirmation: "{,xF24V^tbupd6yjW*X,492[NRdhXJLz}PbE29]$JPn34cVN)o")
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

puts "BEGIN: Creating Favorites"
User.all.each do |user|
  events = Event.order("RANDOM()").first((1..10).to_a.sample)
  events.each { |event| user.favorite_events << event }
end
puts "END:   Creating Favorites"
