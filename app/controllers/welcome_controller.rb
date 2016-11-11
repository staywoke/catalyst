class WelcomeController < ApplicationController
  before_action :load_legacy_survey_response, only: :new

  def new
    @user = User.new

    if @legacy_survey_response
      @legacy_survey_response.statistics.viewed!
      @user.inflate_from_legacy_survey_response(@legacy_survey_response)
    end
  end

  private

  def load_legacy_survey_response
    return unless params[:token]

    legacy_survey_response = LegacySurveyResponse.find_by_token(params[:token])

    return unless legacy_survey_response
    return if User.where(legacy_survey_response_id: legacy_survey_response.id).any?

    @legacy_survey_response = legacy_survey_response
  end
end
