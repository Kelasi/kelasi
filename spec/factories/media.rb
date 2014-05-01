# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :medium do
    user
    file_size 1
    file_name "MyString"

    factory :image_file do
      content_type "image/jpeg"
      medium File.open(File.join(Rails.root, 'spec/support/files/image.jpg'))
      attachable { |a| a.association(:image) }
    end

    factory :document_file do
      content_type "application/doc"
      medium File.open(File.join(Rails.root, 'spec/support/files/file.doc'))
      attachable { |a| a.association(:document) }
    end

    factory :invalid_size_image do
      content_type "image/jpeg"
      medium File.open(File.join(Rails.root, 'spec/support/files/invalid_size_image.jpg'))
      attachable { |a| a.association(:image) }
    end
  end
end
