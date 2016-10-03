class AddTokenToLegacySurveyResponse < ActiveRecord::Migration[5.0]
  def change
    add_column :legacy_survey_responses, :token, :string
  end
end
