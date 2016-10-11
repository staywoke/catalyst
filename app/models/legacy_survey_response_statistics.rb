class LegacySurveyResponseStatistics < ApplicationRecord
  belongs_to :legacy_survey_response

  def viewed!
    LegacySurveyResponseStatistics.increment_counter(:view_count, self.id)
  end

  def redeemed!
    return if redeemed_at.present?
    update_attribute(:redeemed_at, Time.zone.now)
  end
end
