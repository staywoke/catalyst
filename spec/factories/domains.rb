FactoryGirl.define do
  factory :domain do
    name 'Domain'

    factory :cities do
      name 'Cities'
    end

    factory :counties do
      name 'Counties'
    end
  end
end
