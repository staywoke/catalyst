class CalculateCanonicalAnswerJob
  include Sidekiq::Worker

  def perform(klass, id)
    response = klass.constantize.find(id)
    response.calculate_canonical_answer!
  end
end
