FactoryGirl.define do

  factory :person do
    sequence(:first_name) { |n| "John_#{n}" }
    sequence(:last_name) { |n| "Doe_#{n}" }
    sequence(:email) { |n| "johndoesemail_#{n}@domain.com"}
    age {Random.rand(15..99)}
    bio "Some text here"
    sequence(:nickname) { |n| "nick_#{n}" }
  end

end
