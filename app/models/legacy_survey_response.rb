class LegacySurveyResponse < ApplicationRecord
  before_save do |record|
    record.token = SecureRandom.uuid unless token.present?
  end
end
