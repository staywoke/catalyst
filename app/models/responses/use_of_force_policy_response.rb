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
      self.update_column(
        :canonical_answer, Digest::MD5.hexdigest(open(self.url).read)
      )

      if user.admin? && self.correct.nil?
        self.update_column(:correct, true)
      end
    end
  end
end
