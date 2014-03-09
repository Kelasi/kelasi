require 'required_param'

class Timeline < ActiveRecord::Base
  has_many :timeline_user_permissions
  has_many :users, through: :timeline_user_permissions
  has_many :timeline_posts

  validates :title, presence: true

  PAGINATION_LIMIT = 20
  def self.stream(page: required('page number'))
    self.order('created_at desc').limit(PAGINATION_LIMIT)
                                 .offset(PAGINATION_LIMIT * (page -1))
  end

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

  def add_member(user, options={})
    role = options[:role] || TimelineUserPermission::Roles::PARTICIPANTS
    raise "expecting an instance of User" unless user.instance_of? User
    timeline_user_permissions.find_by(user: user) or
      timeline_user_permissions.create!(user: user, role: role)
  end

  def role?(user)
    timeline_user_permissions.find_by(user: user).role
  end
end
