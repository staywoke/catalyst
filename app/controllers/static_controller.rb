class StaticController < ApplicationController
  def home
    @user = User.new
  end
end
