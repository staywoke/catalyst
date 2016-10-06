class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @tasks = Task.all
  end
end
