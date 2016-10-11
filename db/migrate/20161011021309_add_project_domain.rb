class AddProjectDomain < ActiveRecord::Migration[5.0]
  def change
    domain = Domain.find_by_name('100 Largest Cities by Population')

    ProjectDomain.create!(
      project_key: 'use_of_force_policy',
      domain_id: domain.id,
    )
  end
end
