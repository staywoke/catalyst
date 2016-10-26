class Domain < ApplicationRecord
  has_many :domain_memberships
  has_many :cities, through: :domain_memberships

  validates :name, presence: true, uniqueness: true

  def add(resource)
    return if include?(resource)

    membership = domain_memberships.new
    membership.send("#{resource.class.name.downcase}=", resource)
    membership.save

    CalibrateTasksJob.perform_async
  end

  def remove(resource)
    return unless include?(resource)

    membership = domain_memberships.where(
      resource.class.name.downcase => resource
    )

    membership.destroy

    CalibrateTasksJob.perform_async
  end

  def set(city_ids)
    set_cities(city_ids)
    CalibrateTasksJob.perform_async
  end

  private

  def include?(resource)
    valid_membership?(resource)

    domain_memberships.where(
      resource.class.name.downcase => resource
    ).count > 0
  end

  def valid_membership?(resource)
    column_name = "#{resource.class.name.downcase}_id"
    raise unless DomainMembership.column_names.include?(column_name)
  end

  def set_cities(city_ids)
    to_be_removed = self.cities.pluck(:id) - city_ids
    to_be_added = city_ids - self.cities.pluck(:id)

    to_be_removed.each do |city_id|
      domain_memberships.where(city_id: city_id).destroy_all
    end

    to_be_added.each do |city_id|
      domain_memberships.create(city_id: city_id)
    end
  end
end
