class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: [:edit, :update]

  def index
    @projects = Projects::Base.subclasses
  end

  def update
    @project.domain_ids = params[:project][:domains].select { |x| x.present? }.map { |x| x.to_i }
    redirect_to admin_projects_path
  end

  private

  def set_project
    @project = Projects::Base.find_by_key(params[:key])
  end
end
