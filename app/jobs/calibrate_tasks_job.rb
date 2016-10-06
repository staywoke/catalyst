class CalibrateTasksJob < ApplicationJob
  def perform
    Projects::Base.subclasses.each do |project|
      calibrate_cities(project)
      calibrate_counties(project)
    end
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

  def calibrate_counties(project)
    existing_county_ids = Task.
      where(project_key: project::KEY).
      where('county_id IS NOT NULL').
      pluck(:county_id).uniq

    new_county_ids = project.county_ids

    to_be_removed = existing_county_ids - new_county_ids
    to_be_added = new_county_ids - existing_county_ids

    Task.where(project_key: project::KEY, county_id: to_be_removed).destroy_all

    to_be_added.each do |county_id|
      Task.create(project_key: project::KEY, county_id: county_id)
    end
  end
end
