puts "BEGIN: Creating Events"
events = []
(1..200).each do
  events << { name: Faker::Company.catch_phrase, description: Faker::Lorem.sentences(1)[0] }
end
Event.create(events)
puts "END:   Creating Events"
