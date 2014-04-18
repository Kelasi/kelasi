require 'valid_mime_types'
# encoding: utf-8

class MediumUploader < CarrierWave::Uploader::Base

  CarrierWave::SanitizedFile.sanitize_regexp = /[^\w\u0600-\u06FF\.\-]/

  permissions 0644

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  after :cache, :update_file_attributes

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{mounted_as.to_s.pluralize}/"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    MIME::valid_extensions
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    file_type = file.content_type.split('/').first
    random_folder = @filename[0,2]
    random_name = "#{secure_token}.#{file.extension}" if original_filename.present?

    "#{file_type}/#{random_folder}/#{random_name}"
  end

  protected
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
