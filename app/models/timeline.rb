require 'required_param'

class Timeline < ActiveRecord::Base
  has_many :timeline_user_permissions
  has_many :users, through: :timeline_user_permissions
  has_many :timeline_posts

  validates :title, presence: true

  def self.create!(title: required('title'), admin: required('admin'))
    timeline = self.new title: title.to_s
    timeline.save!
    timeline.timeline_user_permissions.create user: admin, role: TimelineUserPermission::Roles::ADMIN
    timeline
  end

  def admin?(user)
    return true if self.timeline_user_permissions.where(role: TimelineUserPermission::Roles::ADMIN
                                                       ).map(&:user).include? user
  end
end
