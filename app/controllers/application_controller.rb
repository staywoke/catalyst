class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def after_sign_in_path_for
    dashboard_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(
        :first_name,
        :last_name,
        :legacy_survey_response_id,
        :zip_code,
      )
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(
        :first_name,
        :last_name,
        :zip_code,
      )
    end
  end
end
