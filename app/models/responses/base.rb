module Responses
  class Base < ApplicationRecord
    self.abstract_class = true

    belongs_to :task
    belongs_to :user

    before_save do |record|
      record.token = SecureRandom.uuid unless token.present?
    end

    after_commit do |record|
      ::CalculateCanonicalAnswerJob.perform_later(record.class.name, record.id)
    end

    def self.find_by_token(token)
      subclasses.each do |klass|
        result = klass.where(token: token).first
        return result if result
      end
    end

    def self.response_count_for(city)
      task_ids = Task.where(city: city).pluck(:id)

      result = 0

      subclasses.each do |klass|
        result += klass.where(task_id: task_ids).count
      end

      result
    end
  end
end

require_dependency 'responses/use_of_force_policy_response'
