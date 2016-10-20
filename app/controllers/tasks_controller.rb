class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.closest_to(current_user)
  end

  def show
    @task = Task.find_by_token(params[:token])
    @task.viewed_by!(current_user)

    @response = @task.new_response
  end
end
