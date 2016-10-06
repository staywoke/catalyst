class CreateProjectDomains < ActiveRecord::Migration[5.0]
  def change
    create_table :project_domains do |t|
      t.string :project_key
      t.references :domain

      t.timestamps
    end
  end
end
