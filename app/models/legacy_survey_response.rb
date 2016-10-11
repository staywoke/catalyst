class LegacySurveyResponse < ApplicationRecord
  before_save do |record|
    record.token = SecureRandom.uuid unless token.present?
  end

  def statistics
    LegacySurveyResponseStatistics.where(legacy_survey_response: self)
      .first_or_create
  end
end
