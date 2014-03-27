# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium do
    user
    content_type 1
  end
end
