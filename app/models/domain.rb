class Domain < ApplicationRecord
  has_many :domain_memberships
  has_many :cities, through: :domain_memberships
  has_many :counties, through: :domain_memberships

  validates :name, presence: true, uniqueness: true

  def add(resource)
    return if include?(resource)

    membership = domain_memberships.new
    membership.send("#{resource.class.name.downcase}=", resource)
    membership.save
  end

  def remove(resource)
    return unless include?(resource)

    membership = domain_memberships.where(
      resource.class.name.downcase => resource
    )

    membership.destroy
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
end
