class Domain < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
