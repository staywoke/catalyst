class RemoveProjects < ActiveRecord::Migration[5.0]
  def change
    drop_table :projects
  end
end
