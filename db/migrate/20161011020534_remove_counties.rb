class RemoveCounties < ActiveRecord::Migration[5.0]
  def change
    remove_reference :domain_memberships, :county
    remove_reference :tasks, :county

    drop_table :counties
  end
end
