class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    @task = Task.find_by_token(params[:token])

    @response = @task.new_response
    @response.assign_attributes(response_params)

    @response.user = current_user
    @response.task = @task

    if @response.save
      @response.reload
      redirect_to tasks_path(thanks: @response.token)
    else
      render 'tasks/show'
    end
  end

  private

  def response_params
    params[response_params_key].permit(
      *@response.class::ALLOWED_ATTRIBUTES
    )
  end

  def response_params_key
    @response.class.name.sub('::', '').underscore
  end
end
