class Medium < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: :true

  mount_uploader :medium, MediumUploader

  validates :content_type, presence: true
end
