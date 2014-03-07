# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline_post do
    timeline
    user
    parent_id nil
    state 1
    body "MyString"
  end
end
