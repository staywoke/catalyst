class CalculateResponseStatisticsJob < ApplicationJob
  def perform(id)
    user = User.find(id)

    correct = 0
    incorrect = 0

    Responses::Base.reviewed_responses_for(user).each do |response|
      correct += 1 if response.correct?
      incorrect += 1 if response.incorrect?
    end

    statistics = user.statistics

    statistics.correct = correct
    statistics.incorrect = incorrect

    statistics.save!
  end
end
