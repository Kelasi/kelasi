# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline_user_permission do
    user
    timeline
    role { TimelineUserPermission::Roles::ADMIN }
  end
end
