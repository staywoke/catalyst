class City < ApplicationRecord
  validates :name, :state, :latitude, :longitude, presence: true
  validates :state, inclusion: {in: Catalyst.states}
end
