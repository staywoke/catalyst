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

    def self.unreviewed
      result = []

      subclasses.each do |klass|
        result += klass.where('correct IS NULL')
      end

      result
    end

    def self.find_by_token(token)
      subclasses.each do |klass|
        result = klass.where(token: token).first
        return result if result
      end

      nil
    end

    def self.response_count_for(city)
      task_ids = Task.where(city: city).pluck(:id)

      result = 0

      subclasses.each do |klass|
        result += klass.where(task_id: task_ids).count
      end

      result
    end

    def self.reviewed_responses_for(user)
      result = []

      subclasses.each do |klass|
        result += klass.where('correct IS NOT NULL').where(user: user)
      end

      result
    end

    def incorrect?
      correct == false
    end

    def calculate_canonical_answer!
      raise NotImplementedError
    end

    def answer
      raise NotImplementedError
    end

    def approve!(propagate:)
      update_column(:correct, true)
      ::CalculateResponseStatisticsJob.perform_later(user.id)

      ::PropagateResponseJob.perform_later(self.class.name, id) if propagate
    end

    def reject!(propagate:)
      update_column(:correct, false)
      ::CalculateResponseStatisticsJob.perform_later(user.id)

      ::PropagateResponseJob.perform_later(self.class.name, id) if propagate
    end
  end
end

require_dependency 'responses/use_of_force_policy_response'
