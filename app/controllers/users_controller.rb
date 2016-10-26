class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_filter :set_user, only: [:edit, :update]

  def create
    @user = User.new(new_user_params)

    if @user.save
      sign_in(:user, @user)
      redirect_to tasks_path
    else
      render 'welcome/new'
    end
  end

  def update
    old_password = edit_user_params[:old_password]
    new_password = edit_user_params[:new_password]

    edit_user_params.delete(:old_password)
    edit_user_params.delete(:new_password)

    @user.assign_attributes(edit_user_params)

    if @user.valid_password?(old_password)
      @user.password = new_password if new_password.present?
      if @user.save && sign_in(@user, :bypass => true)
        flash[:notice] = 'Your account has been successfully updated.'
        redirect_to tasks_path
      else
        render :edit
      end
    else
      @user.errors.add(:old_password, 'was not correct')
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def edit_user_params
    @_edit_user_params ||= params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :location,
      :new_password,
      :old_password,
    )
  end

  def new_user_params
    @_new_user_params ||= params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :legacy_survey_response_id,
      :location,
      :password,
    )
  end
end
