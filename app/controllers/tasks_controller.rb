class TasksController < ApplicationController
  before_action :redirect_if_not_project_selected
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  respond_to? :js, :html

  def index
    @tasks = Task.by_project(current_user.current_project)
    @project = current_user.current_project
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.js { }
      else
        format.html { render :new }
        format.js { }
      end
    end
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.js { }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:subject, :description, :progress, :task_type, :author_id, :project_id)
    end

    def redirect_if_not_project_selected
      redirect_to root_path unless current_user.current_project
    end

end