module Responses
  class UseOfForcePolicyResponse < ApplicationRecord
    ALLOWED_ATTRIBUTES = [
      :url,
    ]

    belongs_to :task
    belongs_to :user

    validates :url, presence: true
end
