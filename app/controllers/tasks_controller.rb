class TasksController < ApplicationController
  before_action :redirect_if_not_project_selected
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_tasks, only: [:index, :update, :create, :destroy]
  respond_to? :js, :html

  def index
    @project = current_user.current_project
    session[:status] = params[:status]
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.create(task_params)
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def set_tasks
      @tasks = Task.project(current_user.current_project).filter(params.slice(:status))
    end

    def task_params
      params.require(:task).permit(:subject, :description, :progress, :task_type, :status, :author_id, :project_id)
    end

    def redirect_if_not_project_selected
      redirect_to root_path unless current_user.current_project
    end

end