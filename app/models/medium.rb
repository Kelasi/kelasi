class Medium < ActiveRecord::Base
  belongs_to :user
  belongs_to :attachable, polymorphic: :true

  validates :content_type, presence: true
end
