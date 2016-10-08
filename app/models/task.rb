class Task < ApplicationRecord
  belongs_to :city, optional: true
  belongs_to :county, optional: true

  validate :only_one_model

  before_save do |record|
    record.token = SecureRandom.uuid unless token.present?
  end

  def project
    Projects::Base.find_by_key(project_key)
  end

  def locality
    city || county
  end

  def type
    locality.class.name.downcase
  end

  def title
    project::NAME
  end

  def subtitle
    case type
    when 'city'
      "City of #{locality.name}, #{locality.state}"
    when 'county'
      "#{locality.name} County, #{locality.state}"
    end
  end

  def blurb
    project::BLURB
  end

  def description
    project::DESCRIPTION
  end

  private

  def only_one_model
    if city && county
      errors.add(:base, 'only one model can specified per task')
    end
  end
end
