class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  respond_to? :js, :html

  def index
    @projects = Project.search_by(params[:search])
    @project = Project.new
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.create(project_params)
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to profile_path, notice: 'Datos del proyecto modificados correctamente' }
        format.js   { }
      else
        format.html { render :show }
        format.js   { }
      end    
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to new_project_session_path, notice: 'El proyecto ha sido eliminado' }
      format.js { }
    end
  end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :web)
    end
end