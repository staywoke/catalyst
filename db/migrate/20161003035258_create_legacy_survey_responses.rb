class CreateLegacySurveyResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :legacy_survey_responses do |t|
      t.string :name
      t.string :email
      t.string :zip_code

      t.timestamps
    end
  end
end
