class AddLegacySurveyResponseIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :legacy_survey_response, index: true
  end
end
