class Projects::Base < ApplicationRecord
  self.table_name = 'projects'
  validates :name, presence: true, uniqueness: true
end
