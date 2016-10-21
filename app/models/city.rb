class City < ApplicationRecord
  validates :name, :state, presence: true
  validates :state, inclusion: {in: Catalyst.states}

  after_destroy { CalibrateTasksJob.perform_later }
  after_commit { AddGeocodingToCityJob.perform_later(id) }

  acts_as_mappable(
    lat_column_name: :latitude,
    lng_column_name: :longitude,
  )

  def response_count
    Responses::Base.response_count_for(self)
  end
end
