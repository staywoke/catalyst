class RemoveEmailFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :email, :string
    remove_column :users, :email_downcased, :string
  end
end
