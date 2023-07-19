class User < ApplicationRecord
  has_secure_password
  validates :password, presence: true
  validates :email, presence: true
  has_many :events
  has_many :favourites
end