module Responses
  class UseOfForcePolicyResponse < ApplicationRecord
    ALLOWED_ATTRIBUTES = [
      :url,
    ]

    belongs_to :task
    belongs_to :user

    validates :url, presence: true

    after_save do |response|
      CalculateCanonicalAnswerJob.perform_later(response.class.name, self.id)
    end

    def calculate_canonical_answer!
      self.update_attribute(
        :canonical_answer, Digest::MD5.hexdigest(open(self.url).read)
      )
    end
  end
end
