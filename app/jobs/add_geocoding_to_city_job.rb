class AddGeocodingToCityJob < ApplicationJob
  def perform(id)
    city = City.find(id)

    location = Geokit::Geocoders::MultiGeocoder.geocode(
      "#{city.name}, #{city.state}"
    )

    city.latitude = location.latitude
    city.longitude = location.longitude

    city.save!
  end
end
