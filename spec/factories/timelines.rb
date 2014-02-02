# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline do
    title "MyTimeline"

    factory :timeline_with_member do
      after(:create) do |timeline|
        user = FactoryGirl.create :user
        timeline.timeline_user_permissions.create({ user: user, role: TimelineUserPermission::Roles::ADMIN })
      end
    end
  end
end
