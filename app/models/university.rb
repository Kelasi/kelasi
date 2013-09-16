class University < ActiveRecord::Base
  has_many :atendances
  has_many :users, through: :atendances
end
