class CreateResponseStatistics < ActiveRecord::Migration[5.0]
  def change
    create_table :response_statistics do |t|
      t.references :user, foreign_key: true
      t.integer :correct, default: 0, null: false
      t.integer :incorrect, default: 0, null: false

      t.timestamps
    end

    User.pluck(:id).each do |id|
      CalculateResponseStatisticsJob.perform_async(id)
    end
  end
end
