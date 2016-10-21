module Responses
  class UseOfForcePolicyResponse < Responses::Base
    ALLOWED_ATTRIBUTES = [
      :url,
    ]

    validates :url, presence: true

    def calculate_canonical_answer!
      self.update_column(
        :canonical_answer,
        Digest::MD5.hexdigest(open(self.url, allow_redirections: :safe).read),
      )

      if user.admin? && self.correct.nil?
        self.approve!(propagate: true)
      end
    end

    def answer
      url
    end
  end
end
