class Task < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :county, optional: true

  validate :only_one_model

  def project
    Projects::Base.find_by_key(project_key)
  end

  def locality
    city || county
  end

  def type
    locality.class.name.downcase
  end

  private

  def only_one_model
    if city && county
      errors.add(:base, 'only one model can specified per task')
    end
  end
end
