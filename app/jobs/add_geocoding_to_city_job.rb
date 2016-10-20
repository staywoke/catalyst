class AddGeocodingToCityJob < ApplicationJob
  def perform(id)
    city = City.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(
      "#{city.name}, #{city.state}"
    )

    city.update_column(:latitude, location.latitude)
    city.update_column(:longitude, location.longitude)
  end
end
