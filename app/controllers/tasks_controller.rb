class TasksController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @tasks = if params[:location]
               Task.closest_to(location: params[:location])
              elsif current_user
               Task.closest_to(user: current_user)
             else
               Task.random
             end

    if (token = params[:thanks].presence)
      last_response = Responses::Base.find_by_token(token)
      if last_response && last_response.created_at > 5.minutes.ago
        thanks = 'THANK YOU!'
        case @tasks.count
        when 0
        when 1
          thanks += ' We have one more task we could use your help with.'
        when 2
          thanks += ' Here are a couple more tasks we could use your help with.'
        else
          thanks += ' Here are a few more tasks we could use your help with.'
        end
        flash.now[:notice] = thanks
      end
    end
  end

  def show
    @task = Task.find_by_token(params[:token])
    @task.viewed_by!(current_user)

    @response = @task.new_response
  end
end
