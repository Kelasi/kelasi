FactoryGirl.define do
  factory :atendance do
    user
    university
    factory :current_attendance do
      currently_attending true
    end
  end
end
