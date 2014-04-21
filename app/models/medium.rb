class Medium < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: :true

  mount_uploader :medium, MediumUploader

  validates :content_type, presence: true
  validates :file_name, presence: true
  validates :file_size, presence: true
end
