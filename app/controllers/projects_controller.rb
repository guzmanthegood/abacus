class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :current]
  respond_to? :js, :html

  def index
    @projects = Project.search(params[:search])
    @project = Project.new
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def current
    current_user.update(current_project: @project)
    redirect_to project_path(@project), notice: "Proyecto #{@project.name} seleccionado"
  end

  def create
    @project = Project.create(project_params)
  end

  def update
    @project.update(project_params)
  end

  def destroy
    selected_project = (@project == current_user.current_project)
    @project.destroy

    if selected_project
      flash.now.notice = 'El proyecto actual ha sido eliminado'
      flash.keep(:notice)
      render js: "window.location = '#{root_path}'"
    end
  end

  private
    def set_project
      @project = Project.find(params[:id] || params[:project_id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :web, :author_id)
    end
end