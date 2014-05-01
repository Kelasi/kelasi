require 'valid_mime_types'

class MediumUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^\w\u0600-\u06FF\.\-]/

  permissions 0644

  include CarrierWave::MiniMagick

  include ::CarrierWave::Backgrounder::Delay

  storage :file

  after :cache, :update_file_attributes

  def store_dir
    "#{mounted_as.to_s.pluralize}/"
  end

  version :thumb, if: :image? do
    process :resize_to_fill => [64, 64]
    process :quality => 85
  end

  version :small, if: :image? do
    process :resize_to_fit => [240, 240]
    process :quality => 85
  end

  version :large, if: :image? do
    process :resize_to_fit => [720, 720]
    process :quality => 85
  end

  def extension_white_list
    MIME::valid_extensions
  end

  def filename
    file_type = file.content_type.split('/').first
    random_folder = @filename[0,2]
    random_name = "#{secure_token}.#{file.extension}" if original_filename.present?

    "#{file_type}/#{random_folder}/#{random_name}"
  end

  protected
    def image?(new_file)
      new_file.content_type.start_with? 'image'
    end

    def update_file_attributes(new_file)
      model.file_name = file.original_filename if file.original_filename
      model.content_type = file.content_type
      model.file_size = file.size
    end

    def secure_token
      ivar = :"@#{mounted_as}_secure_token"
      model.instance_variable_get(ivar) or model.instance_variable_set(ivar, SecureRandom.uuid)
    end
end
