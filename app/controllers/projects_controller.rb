class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, :current]
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

  def current
    current_user.update(current_project: @project)
    redirect_to project_path(@project), notice: "Proyecto #{@project.name} seleccionado"
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
    redirect = (@project == current_user.current_project)
    @project.destroy
    redirect_to root_path, notice: 'El proyecto actual ha sido eliminado' if redirect
  end

  private
    def set_project
      @project = Project.find(params[:id] || params[:project_id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :web)
    end
end