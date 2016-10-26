class CalibrateTasksJob
  include Sidekiq::Worker

  def perform
    Projects::Base.subclasses.each { |project| calibrate_cities(project) }
  end

  private

  def calibrate_cities(project)
    existing_city_ids = Task.
      where(project_key: project::KEY).
      where('city_id IS NOT NULL').
      pluck(:city_id).uniq

    new_city_ids = project.city_ids

    to_be_removed = existing_city_ids - new_city_ids
    to_be_added = new_city_ids - existing_city_ids

    Task.where(project_key: project::KEY, city_id: to_be_removed).destroy_all

    to_be_added.each do |city_id|
      Task.create(project_key: project::KEY, city_id: city_id)
    end
  end
end
