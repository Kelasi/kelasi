require 'required_param'

class Timeline < ActiveRecord::Base
  has_many :timeline_user_permissions
  has_many :users, through: :timeline_user_permissions
  has_many :timeline_posts

  validates :title, presence: true

  scope :recent_timelines, -> { order('created_at desc') }

  def self.create!(title: required('title'), admin: required('admin'))
    timeline = self.new title: title.to_s
    timeline.save!
    timeline.timeline_user_permissions.create(
      user: admin, role: TimelineUserPermission::Roles::ADMIN
    )
    timeline
  end

  def admin?(user)
    self.timeline_user_permissions.where(
      user: user,
      role: TimelineUserPermission::Roles::ADMIN
    ).any?
  end

  def add_member(user, options={})
    role = options[:role] || TimelineUserPermission::Roles::PARTICIPANTS
    raise "expecting an instance of User" unless user.instance_of? User
    timeline_user_permissions.find_by(user: user) or
      timeline_user_permissions.create!(user: user, role: role)
  end

  def role?(user)
    timeline_user_permissions.find_by(user: user).role
  end

  def recent_posts
    timeline_posts.limit(20)
  end
end
