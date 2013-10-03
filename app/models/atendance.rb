class Atendance < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :university
end
