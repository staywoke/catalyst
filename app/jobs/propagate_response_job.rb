class PropagateResponseJob < ApplicationJob
  def perform(klass, id)
    response = klass.constantize.find(id)

    return unless response.canonical_answer.present?

    other_responses = klass.constantize.
      where(task: response.task).
      where('correct IS NULL').
      where(canonical_answer: response.canonical_answer)

    other_responses.each do |other_response|
      other_response.approve!(propagate: false) if response.correct?
      other_response.reject!(propagate: false) if response.incorrect?
    end
  end
end
