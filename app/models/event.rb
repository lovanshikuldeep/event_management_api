class Event < ApplicationRecord
  validates :title,:description,:location, presence: true
  belongs_to :user
  has_many :attendees
end
