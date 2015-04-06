require 'image_quality'

if Rails.env.test?
  File.open('spec/support/files/invalid_size_image.jpg', 'w+') do |f|
    6.megabytes.times { f.write "\0" }
  end

  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/storage/spec_files"
  end
else
  CarrierWave.configure do |config|
    config.permissions = 0600
    config.directory_permissions = 0700
    config.storage = :file
    config.root = "#{Rails.root}/storage"
  end
end
