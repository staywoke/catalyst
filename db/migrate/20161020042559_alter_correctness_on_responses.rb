class AlterCorrectnessOnResponses < ActiveRecord::Migration[5.0]
  def change
    change_column :use_of_force_policy_responses, :correct, :boolean, default: nil, null: true
  end
end
