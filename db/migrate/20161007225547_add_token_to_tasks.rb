class AddTokenToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :token, :string
    Task.all.each { |task| task.save! }
    change_column :tasks, :token, :string, null: false
  end
end
