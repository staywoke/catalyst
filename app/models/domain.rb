class Domain < ApplicationRecord
  has_many :domain_memberships
  has_many :cities, through: :domain_memberships
  has_many :counties, through: :domain_memberships

  validates :name, presence: true, uniqueness: true
end
