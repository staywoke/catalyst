class AddAllCitiesToDomain < ActiveRecord::Migration[5.0]
  def change
    domain = Domain.create!(name: '100 Largest Cities by Population')

    City.all.each do |city|
      DomainMembership.create!(
        city: city,
        domain: domain,
      )
    end
  end
end
