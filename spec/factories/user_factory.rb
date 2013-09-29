FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name  "Doe"
    password   "password"
    email      "john.doe@example..com"

    factory :user_with_university do
      after(:create) do |user|
        user.universities.create FactoryGirl.attributes_for :university
      end
    end
  end
end
