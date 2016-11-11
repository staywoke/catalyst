class AddGeocodingToUserJob
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(user.location)

    raise 'missing location latitude' unless location.latitude.present?
    raise 'missing location longitude' unless location.longitude.present?

    user.update_column(:latitude, location.latitude)
    user.update_column(:longitude, location.longitude)
  end
end
