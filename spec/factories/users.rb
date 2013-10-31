FactoryGirl.define do
  factory :user do
    first_name            "John"
    last_name             "Doe"
    password              "password"
    password_confirmation "password"
    salt                  "asdasdastr4325234324sdfds"
    crypted_password      { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    email                 "john.doe@example.com"

    factory :user_with_university do
      after(:create) do |user|
        user.universities.create FactoryGirl.attributes_for :university
      end
    end
  end
end
