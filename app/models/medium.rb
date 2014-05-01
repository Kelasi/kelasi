require 'file_size_validator'

class Medium < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: :true

  mount_uploader :medium, MediumUploader
  process_in_background :medium

  validates :content_type, presence: true
  validates :file_name, presence: true
  validates :file_size, presence: true
  validates :medium, file_size: { maximum: (Rails.env.test? ? 0.6.megabytes.to_i : 5.megabytes.to_i) }
end
