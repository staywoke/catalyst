class Projects::Base
  MINIMUM_RESPONSES = 1

  def self.find_by_key(key)
    subclasses.find { |klass| klass::KEY == key }
  end

  def self.response_class
    ('Responses::' + self.name.split('::').last + 'Response').constantize
  end

  def self.new_response
    self.response_class.new
  end

  def self.blurb
    "projects/#{self::KEY}/blurb"
  end

  def self.description
    "projects/#{self::KEY}/description"
  end

  def self.form
    "projects/#{self::KEY}/form"
  end

  def self.city_ids
    ::DomainMembership.
      where(domain: self.domains).
      where('city_id IS NOT NULL').
      pluck(:city_id).uniq
  end

  def self.domains
    ::Domain.where(id: self.domain_ids)
  end

  def self.domain_ids
    ::ProjectDomain.where(project_key: self::KEY).pluck(:domain_id)
  end

  def self.domain_ids=(domain_ids)
    to_be_removed = self.domain_ids - domain_ids
    to_be_added = domain_ids - self.domain_ids

    to_be_removed.each do |domain_id|
      ::ProjectDomain.where(
        project_key: self::KEY,
        domain_id: domain_id
      ).destroy_all
    end

    to_be_added.each do |domain_id|
      ::ProjectDomain.create(project_key: self::KEY, domain_id: domain_id)
    end

    return if to_be_removed.empty? && to_be_added.empty?
    ::CalibrateTasksJob.perform_later
  end
end

require_dependency 'projects/use_of_force_policy'
