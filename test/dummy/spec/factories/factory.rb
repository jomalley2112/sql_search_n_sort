FactoryBot.define do

  factory :person do
    sequence(:first_name) { |n| "John_#{n}" }
    sequence(:last_name) { |n| "Doe_#{n}" }
    sequence(:email) { |n| "johndoesemail_#{n}@domain.com"}
    age {Random.rand(15..99)}
    bio {"Some text here"}
    sequence(:nickname) { |n| "nick_#{n}" }
  end

  factory :member, class: Admin::Member do
    sequence(:first_name) { |n| "John_#{n}" }
    sequence(:last_name) { |n| "Doe_#{n}" }
    sequence(:email) { |n| "johndoesemail_#{n}@domain.com"}
  end

  factory :vehicle do
  	year {2010}
  	manufacturer {"Chevrolet"}
  	model {"Silverado"}
  	engine {"5.0 liter"}
  	color {"Pewter"}
  end

  factory :product do
    sequence(:name) { |n| "cog_#{n}" }
    sequence(:descr) { |n| "random description #{n}" }
    sequence(:price) { |n| "#{n}" }
    sequence(:date_produced) { |n| Time.now - n.days }
    sequence(:manufacturer) { |n| "Company #{n}" } 
  end


  factory :article do
    sequence(:headline) { |n| "Headline #{n}" }
    sequence(:by_line) { |n| "Journalist #{n}" }
    sequence(:date_pub) { |n| Time.now - n.days }
    sequence(:body) { |n| "The main article... #{n}" }
  end

  factory :comment do
    article
    sequence(:ctext) { |n| "These are comments __#{n}__" }
    sequence(:commentator) { |n| "myHandle_#{n}" }
  end

end
