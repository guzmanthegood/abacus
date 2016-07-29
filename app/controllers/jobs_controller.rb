class JobsController < ApplicationController
  before_action :set_job, only: [:destroy]

  respond_to? :js

  def create
    @job = Job.create(job_params)
  end

  def destroy
    @job.destroy
  end

  private
    def set_job
      @job = Job.find(params[:id])
    end

    def job_params
      params.require(:job).permit(:task_id, :user_id, :performed_at, :description, :hours)
    end
end