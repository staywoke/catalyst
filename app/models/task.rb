class Task < ApplicationRecord
  belongs_to :city

  acts_as_mappable(
    lat_column_name: :latitude,
    lng_column_name: :longitude,
    :through => :city,
  )

  before_save do |record|
    record.token = SecureRandom.uuid unless token.present?
  end

  def self.closest_to(user, limit: 2)
    Task.by_distance(origin: [user.latitude, user.longitude])
      .references(:cities)
      .includes(:city)
      .limit(limit)
  end

  def viewed_by!(user)
    TaskView.create!(
      task: self,
      user: user,
    )
  end

  def project
    Projects::Base.find_by_key(project_key)
  end

  def response_class
    project.response_class
  end

  def new_response
    project.new_response
  end

  def title
    project::NAME
  end

  def subtitle
    "#{city.name}, #{city.state}"
  end

  def blurb
    project.blurb
  end

  def description
    project.description
  end

  def form
    project.form
  end
end
