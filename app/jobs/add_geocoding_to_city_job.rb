class AddGeocodingToCityJob
  include Sidekiq::Worker

  def perform(id)
    city = City.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(
      "#{city.name}, #{city.state}"
    )

    raise 'missing location latitude' unless location.latitude.present?
    raise 'missing location longitude' unless location.longitude.present?

    city.update_column(:latitude, location.latitude)
    city.update_column(:longitude, location.longitude)
  end
end
