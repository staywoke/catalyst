class AddGeocodingToUserJob
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(user.location)

    raise unless location.latitude.present?
    raise unless location.latitude.present?

    user.update_column(:latitude, location.latitude)
    user.update_column(:longitude, location.longitude)
  end
end
