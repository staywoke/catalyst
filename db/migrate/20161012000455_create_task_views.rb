class CreateTaskViews < ActiveRecord::Migration[5.0]
  def change
    create_table :task_views do |t|
      t.references :task, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
