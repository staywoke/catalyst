class Admin::ProjectsController < Admin::BaseController
  before_filter :set_project, only: [:show, :edit, :update]

  def index
    @projects = Projects::Base.subclasses
  end

  def update
    @project.domain_ids = params[:project][:domains].select { |x| x.present? }
    redirect_to admin_project_path(key: params[:key])
  end

  private

  def set_project
    @project = Projects::Base.find_by_key(params[:key])
  end
end
