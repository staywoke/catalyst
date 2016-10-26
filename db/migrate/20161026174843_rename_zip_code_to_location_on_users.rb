class RenameZipCodeToLocationOnUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :zip_code, :location
  end
end
