FactoryGirl.define do
  sequence :email do |n|
    "bid#{n}@bood.bad"
  end

  factory :john_galt, class: User do
    first_name              "John"
    last_name               "Galt"
    profile_name            "JohnGalt"
    password                "password"
    salt                    "asdasdastr4325234324sdfds"
    crypted_password        { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    email                   "johnGalt@universe"
  end

  factory :user, aliases: [:introduced_user] do
    first_name            "John"
    last_name             "Doe"
    password              "password"
    salt                  "asdasdastr4325234324sdfds"
    crypted_password      { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    email
    introducer            { (User.find_by profile_name: "JohnGalt") or (FactoryGirl.create :john_galt) }

    factory :user_with_university do
      after(:create) do |user|
        user.universities.create FactoryGirl.attributes_for :university
      end
    end

    factory :user_with_timeline do
      ignore do
        timeline { FactoryGirl.create :timeline }
        role     { TimelineUserPermission::Roles::ADMIN }
      end

      after(:create) do |user, evaluator|
        user.timeline_user_permissions.create(
          timeline: evaluator.timeline,
          role: evaluator.role
        )
      end
    end
  end
end
