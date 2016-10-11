class DomainMembership < ApplicationRecord
  belongs_to :domain
  belongs_to :city
end
