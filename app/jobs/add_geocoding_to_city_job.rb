class AddGeocodingToCityJob
  include Sidekiq::Worker

  def perform(id)
    city = City.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(
      "#{city.name}, #{city.state}"
    )

    raise unless location.latitude.present?
    raise unless location.latitude.present?

    city.update_column(:latitude, location.latitude)
    city.update_column(:longitude, location.longitude)
  end
end
