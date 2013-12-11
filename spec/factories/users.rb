FactoryGirl.define do
  sequence :email do |n|
    "bid#{n}@bood.bad"
  end

  factory :user, aliases: [:introducer, :introduced_user] do
    first_name            "John"
    last_name             "Doe"
    password              "password"
    salt                  "asdasdastr4325234324sdfds"
    crypted_password      { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    email
    introducer            { u = FactoryGirl.build :user, introducer: nil; u.save validate: false; u }

    factory :user_with_university do
      after(:create) do |user|
        user.universities.create FactoryGirl.attributes_for :university
      end
    end
  end
end
