class CreateUseOfForcePolicyResponses < ActiveRecord::Migration[5.0]
  def change
    create_table :use_of_force_policy_responses do |t|
      t.string :url
      t.references :task, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :correct, default: false, null: false

      t.timestamps
    end
  end
end
