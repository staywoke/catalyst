class CreateLegacySurveyResponseStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :legacy_survey_response_statistics do |t|
      t.references :legacy_survey_response, foreign_key: true, index: {
        name: 'index_lsrs_on_legacy_survey_response_id',
      }

      t.integer :view_count, default: 0, null: false
      t.datetime :redeemed_at

      t.timestamps
    end
  end
end
