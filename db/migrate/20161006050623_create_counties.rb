class CreateCounties < ActiveRecord::Migration[5.0]
  def change
    create_table :counties do |t|
      t.string :name
      t.string :state
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
