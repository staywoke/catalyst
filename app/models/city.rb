class City < ApplicationRecord
  validates :name, :state, :latitude, :longitude, presence: true
  validates :state, inclusion: {in: Catalyst.states}

  after_destroy { CalibrateTasksJob.perform_later }

  before_validation do
    if name_changed? || state_changed?
      location = Geokit::Geocoders::MultiGeocoder.geocode("#{name}, #{state}")

      self.latitude = location.latitude
      self.longitude = location.longitude
    end
  end

  acts_as_mappable(
    lat_column_name: :latitude,
    lng_column_name: :longitude,
  )
end
