class Task < ApplicationRecord
  belongs_to :city


  before_save do |record|
    record.token = SecureRandom.uuid unless token.present?
  end

  def self.closest_to(user, limit: 2)
    Task.by_distance(origin: user.zip_code)
      .references(:cities)
      .includes(:city)
      .limit(limit)
  end

  def project
    Projects::Base.find_by_key(project_key)
  end

  def title
    project::NAME
  end

  def subtitle
    "#{city.name}, #{city.state}"
  end

  def blurb
    project::BLURB
  end

  def description
    project::DESCRIPTION
  end
end
