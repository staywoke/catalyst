class AddCanonicalAnswerToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :use_of_force_policy_responses, :canonical_answer, :string
  end
end
