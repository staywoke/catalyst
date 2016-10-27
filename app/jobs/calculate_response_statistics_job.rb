class CalculateResponseStatisticsJob
  include Sidekiq::Worker

  def perform(id)
    user = User.find(id)

    # TODO: make hash tables for correct and incorrect
    # mapping task_ids to true/false values 
    # At the end, map the "correct" and "incorrect"
    # to the true / false counts
    correct = Hash.new(0)
    incorrect = Hash.new(0)

    Responses::Base.reviewed_responses_for(user).each do |response|
      if response.correct?
        correct[response.task_id] = 1
      elsif response.incorrect?
        incorrect[response.task_id] = 1
      end
    end

    statistics = user.statistics

    statistics.correct = correct.values.reduce(0, :+)
    statistics.incorrect = incorrect.values.reduce(0, :+)

    statistics.save!
  end
end
