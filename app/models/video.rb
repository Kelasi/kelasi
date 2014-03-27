class Video < ActiveRecord::Base
  has_one :medium, as: :attachable
end
