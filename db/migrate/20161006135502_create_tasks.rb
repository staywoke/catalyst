class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :project_key
      t.references :city, foreign_key: true
      t.references :county, foreign_key: true

      t.timestamps
    end
  end
end
