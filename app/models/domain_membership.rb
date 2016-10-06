class DomainMembership < ApplicationRecord
  belongs_to :domain
  belongs_to :city
  belongs_to :county

  validate :only_one_model

  private

  def only_one_model
    if city && county
      errors.add(:base, 'only one model can specified per membership')
    end
  end
end
