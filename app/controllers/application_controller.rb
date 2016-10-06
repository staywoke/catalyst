class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from 'NotAuthorized' do |exception|
    render_error_page(status: 403, text: 'Forbidden')
  end

  private

  def render_error_page(status:, text:, template: 'errors/routing')
    respond_to do |format|
      format.json { render json: {errors: [message: "#{status} #{text}"]}, status: status }
      format.html { render template: template, status: status, layout: false }
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end
end

class NotAuthorized < StandardError; end
