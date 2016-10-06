class County < ApplicationRecord
  validates :name, :state, :latitude, :longitude, presence: true
end
