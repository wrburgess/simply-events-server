class Event < ActiveRecord::Base
  validates :name, presence: true

  has_many :favorites
  has_many :favorite_users, through: :favorites, source: :user
end
