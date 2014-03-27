class Audio < ActiveRecord::Base
  has_one :medium, as: :attachable
end
