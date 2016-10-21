class AddTokenToResponses < ActiveRecord::Migration[5.0]
  def change
    add_column :use_of_force_policy_responses, :token, :string
    Responses::UseOfForcePolicyResponse.all.each(&:save!)
  end
end
