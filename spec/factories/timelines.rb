# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline do
    title "MyTimeline"

    factory :timeline_with_member, aliases: [:timeline_with_admin] do
      after(:create) do |timeline|
        user = FactoryGirl.create :user
        timeline.timeline_user_permissions.create({ user: user, role: TimelineUserPermission::Roles::ADMIN })
      end

      factory :timeline_with_some_members do
        ignore do
          num_members 5
        end

        after :create do |timeline, evaluator|
          create_list(:timeline_user_permission, evaluator.num_members, timeline: timeline, role: 2)
        end
      end
    end
  end
end
