# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vehicle do
    year 1
    manufacturer "MyString"
    model "MyString"
    color "MyString"
    engine "MyString"
    doorrs 1
    cylinders 1
  end
end
