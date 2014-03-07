require 'required_param'

class TimelinePost < ActiveRecord::Base

  module States
    ACTIVE      = 1
    DEACTIVE    = 2

    AllStates   = Array(1..2)
  end

  scope :active_posts, -> { where(state: States::ACTIVE) }

  belongs_to :user
  belongs_to :timeline

  has_many :replies, class_name: "TimelinePost", foreign_key: "parent_id"
  belongs_to :timeline_post, class_name: "TimelinePost"

  validates :state, presence: true, inclusion: { in: States::AllStates }
  validates :body,  presence: true
end
