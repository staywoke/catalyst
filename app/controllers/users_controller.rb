class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to dashboard_path
    else
      render 'welcome/new'
    end
  end

  private

  def user_params
    params.required(:user).permit(
      :first_name,
      :last_name,
      :email,
      :zip_code,
      :legacy_survey_response_id,
    )
  end
end
