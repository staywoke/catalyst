class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.order('RANDOM()').limit(3)
  end

  def show
    @task = Task.find_by_token(params[:key])
  end
end
