class Place < ApplicationRecord
  has_many :favourites, dependent: :destroy
end
