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

  def self.closest_to(user: nil, location: nil, limit: 2)
    raise if user.nil? && location.nil?
    raise if user.present? && location.present?

    results = []

    location = if user
                 [user.latitude, user.longitude]
               else
                 response = Geokit::Geocoders::MultiGeocoder.geocode(location)
                 [response.latitude, response.longitude]
               end

    tasks = Task.by_distance(origin: location)
      .references(:cities)
      .includes(:city)

    tasks.each do |task|
      next if user && task.response_from?(user)
      next if task.enough_responses?

      results << task

      return results if results.count == limit
    end

    results
  rescue
    self.random
  end

  def self.random(limit: 2)
    results = []

    tasks = Task.order('RANDOM()')
      .references(:cities)
      .includes(:city)

    tasks.each do |task|
      next if task.enough_responses?
      results << task
      return results if results.count == limit
    end

    results
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

  def responses
    response_class.where(task: self).order(:id)
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

  def response_from?(user)
    response_class.where(task: self, user: user).count > 0
  end

  def enough_responses?
    count = response_class.where(task: self).where('correct IS NOT false').count
    count >= project::MINIMUM_RESPONSES
  end
end
