FactoryGirl.define do

  factory :person do
    sequence(:first_name) { |n| "John_#{n}" }
    sequence(:last_name) { |n| "Doe_#{n}" }
    sequence(:email) { |n| "johndoesemail_#{n}@domain.com"}
    age {Random.rand(15..99)}
    bio "Some text here"
    sequence(:nickname) { |n| "nick_#{n}" }
  end

  factory :vehicle do
  	year 2010
  	manufacturer "Chevrolet"
  	model "Silverado"
  	engine "5.0 liter"
  	color "Pewter"
  end

  factory :product do
    sequence(:name) { |n| "cog_#{n}" }
    descr { "random description #{Random.rand(1..20)}" }
    price { "#{Random.rand(1..250)}" }
    date_produced { Time.now - Random.rand(1..100).days }
    manufacturer { "Company #{Random.rand(1..5)}" } 
  end


  factory :article do
    headline "Headline #{Random.rand(1..100)}"
    by_line "Journalist #{Random.rand(1..5)}"
    date_pub { Time.now - Random.rand(1..100).days }
    body "The main article... #{Random.rand(0..50)}"
  end

end
