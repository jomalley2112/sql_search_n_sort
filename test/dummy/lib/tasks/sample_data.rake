namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_people
  end
end    

def make_people
  75.times do |n|
    last_name = Faker::Name.last_name
    first_name = Faker::Name.first_name
    email = Faker::Internet.email
    age = Random.rand(18..105)
    bio = Faker::Lorem.words(10).join(' ')
    Person.create!(last_name: last_name, first_name: first_name, age: age, bio: bio, email: email)
  end
end