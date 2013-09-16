class Atendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :university
end
