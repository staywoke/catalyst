class County < ApplicationRecord
  validates :name, :state, :latitude, :longitude, presence: true
  validates :state, inclusion: {in: Catalyst.states}

  after_destroy { CalibrateTasksJob.perform_later }
end
