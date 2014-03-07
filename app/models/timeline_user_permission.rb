class TimelineUserPermission < ActiveRecord::Base

  module Roles
    ADMIN           = 1
    PARTICIPANTS    = 2
    FOLLOWERS       = 3

    AllRoles = Array(1..3)
  end

  belongs_to :user
  belongs_to :timeline

  validates :role, presence: true, inclusion: { in: Roles::AllRoles }
end
