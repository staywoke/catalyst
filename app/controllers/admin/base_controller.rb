class Admin::BaseController < ApplicationController
  before_action :require_admin!

  def require_admin!
    raise NotAuthorized unless current_user.admin?
  end
end
