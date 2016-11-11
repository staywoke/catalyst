# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# fake a lat/long so things are useable without an active internet connection (until the Geokit worker can reach out and resolve the city)
def random_location
  {
    latitude: (360 * rand - 180),
    longitude: (360 * rand - 180),
  }
end

CITIES = [
  ['New York', 'New York'],
  ['Los Angeles', 'California'],
  ['Chicago', 'Illinois'],
  ['Houston', 'Texas'],
  ['Philadelphia', 'Pennsylvania'],
  ['Phoenix', 'Arizona'],
  ['San Antonio', 'Texas'],
  ['San Diego', 'California'],
  ['Dallas', 'Texas'],
  ['San Jose', 'California'],
  ['Austin', 'Texas'],
  ['Jacksonville', 'Florida'],
  ['Indianapolis', 'Indiana'],
  ['San Francisco', 'California'],
  ['Columbus', 'Ohio'],
  ['Fort Worth', 'Texas'],
  ['Charlotte', 'North Carolina'],
  ['Detroit', 'Michigan'],
  ['El Paso', 'Texas'],
  ['Memphis', 'Tennessee'],
  ['Boston', 'Massachusetts'],
  ['Seattle', 'Washington'],
  ['Denver', 'Colorado'],
  ['Washington', 'DC'],
  ['Nashville-Davidson', 'Tennessee'],
  ['Baltimore', 'Maryland'],
  ['Louisville/Jefferson', 'Kentucky'],
  ['Portland', 'Oregon'],
  ['Oklahoma ', 'Oklahoma'],
  ['Milwaukee', 'Wisconsin'],
  ['Las Vegas', 'Nevada'],
  ['Albuquerque', 'New Mexico'],
  ['Tucson', 'Arizona'],
  ['Fresno', 'California'],
  ['Sacramento', 'California'],
  ['Long Beach', 'California'],
  ['Kansas ', 'Missouri'],
  ['Mesa', 'Arizona'],
  ['Virginia Beach', 'Virginia'],
  ['Atlanta', 'Georgia'],
  ['Colorado Springs', 'Colorado'],
  ['Raleigh', 'North Carolina'],
  ['Omaha', 'Nebraska'],
  ['Miami', 'Florida'],
  ['Oakland', 'California'],
  ['Tulsa', 'Oklahoma'],
  ['Minneapolis', 'Minnesota'],
  ['Cleveland', 'Ohio'],
  ['Wichita', 'Kansas'],
  ['Arlington', 'Texas'],
  ['New Orleans', 'Louisiana'],
  ['Bakersfield', 'California'],
  ['Tampa', 'Florida'],
  ['Honolulu', 'Hawaii'],
  ['Anaheim', 'California'],
  ['Aurora', 'Colorado'],
  ['Santa Ana', 'California'],
  ['St. Louis', 'Missouri'],
  ['Riverside', 'California'],
  ['Corpus Christi', 'Texas'],
  ['Pittsburgh', 'Pennsylvania'],
  ['Lexington-Fayette', 'Kentucky'],
  ['Anchorage', 'Alaska'],
  ['Stockton', 'California'],
  ['Cincinnati', 'Ohio'],
  ['St. Paul', 'Minnesota'],
  ['Toledo', 'Ohio'],
  ['Newark', 'New Jersey'],
  ['Greensboro', 'North Carolina'],
  ['Plano', 'Texas'],
  ['Henderson', 'Nevada'],
  ['Lincoln', 'Nebraska'],
  ['Buffalo', 'New York'],
  ['Fort Wayne', 'Indiana'],
  ['Jersey ', 'New Jersey'],
  ['Chula Vista', 'California'],
  ['Orlando', 'Florida'],
  ['St. Petersburg', 'Florida'],
  ['Norfolk', 'Virginia'],
  ['Chandler', 'Arizona'],
  ['Laredo', 'Texas'],
  ['Madison', 'Wisconsin'],
  ['Durham', 'North Carolina'],
  ['Lubbock', 'Texas'],
  ['Winston-Salem', 'North Carolina'],
  ['Garland', 'Texas'],
  ['Glendale', 'Arizona'],
  ['Hialeah', 'Florida'],
  ['Reno', 'Nevada'],
  ['Baton Rouge', 'Louisiana'],
  ['Irvine', 'California'],
  ['Chesapeake', 'Virginia'],
  ['Irving', 'Texas'],
  ['Scottsdale', 'Arizona'],
  ['North Las Vegas', 'Nevada'],
  ['Fremont', 'California'],
  ['Gilbert', 'Arizona'],
  ['San Bernardino', 'California'],
  ['Boise', 'Idaho'],
  ['Birmingham', 'Alabama'],
]

default_domain = Domain.where(name: '100 Largest Cities by Population').first_or_create

CITIES.each do |(name, state)|
  city = City.where(name: name, state: state).first_or_create { |u|
    u.update_attributes(random_location) if Rails.env.development?
  }
  DomainMembership.where(city: city, domain: default_domain).first_or_create
  Task.where(city: city, project_key: :use_of_force_policy).first_or_create
end

if Rails.env.development?
  user = User.where(
    email: 'admin@staywoke.org'
  ).first_or_create(random_location.merge(
    first_name: 'Example',
    last_name: 'User',
    password: 'password',
    password_confirmation: 'password',
    location: 'San Francisco'
  ))
  user.admin = true
  user.save!
end
