class CreateDomainMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :domain_memberships do |t|
      t.references :domain, foreign_key: true
      t.references :city, foreign_key: true
      t.references :county, foreign_key: true

      t.timestamps
    end
  end
end
