class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :atendances
  has_many :universities, through: :atendances

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, index: :not_analyzed
    indexes :first_name, type: 'string'
    indexes :last_name, type: 'string'
    indexes :universities, as: proc {uni_names.join '|'}
  end

  after_touch() { tire.update_index }

  def uni_names
    unless universities.empty?
      universities.map {|u| u.name}
    else
      []
    end
  end

  def self.search_user params
    search load: true do
      query do
        boolean do
          must { string "first_name:#{params[:first_name]}" } unless params[:first_name].blank?
          must { string "last_name:#{params[:last_name]}" } unless params[:last_name].blank?
          must { string "universities:#{params[:university]}" } unless params[:university].blank?
        end
      end
    end.results
  end
end
