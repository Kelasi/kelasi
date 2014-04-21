# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium, aliases: [:image_file] do
    user
    content_type "image/jpeg"
    medium File.open(File.join(Rails.root, 'spec/support/files/image.jpg'))
    file_size 1
    file_name "MyString"
    attachable { |a| a.association(:image) }
  end
end
