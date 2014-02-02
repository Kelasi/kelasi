class Timeline < ActiveRecord::Base
  has_many :timeline_user_permissions
  has_many :users, through: :timeline_user_permissions

  validates :title, presence: true
end
