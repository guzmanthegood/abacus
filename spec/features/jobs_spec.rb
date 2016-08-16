require 'rails_helper'
include TasksHelper
include JobsHelper

feature 'Jobs' do
  let(:user)    {create(:user)}
  let!(:project) {create(:project)}

  before do
    login user
    user.update(current_project: project)
    @task = create(:task, project: project)
  end

  scenario 'shows jobs tab and edit task tab in task screen', :js do
    visit tasks_path

    click_link subject_short(@task.subject)
    within 'ul.nav.nav-tabs' do
      expect(page).to have_link 'Tiempo dedicado'
    end

    click_link 'Tiempo dedicado'
    within 'ul.nav.nav-tabs' do
      expect(page).to have_link "Editar tarea ##{@task.id}"
    end
  end

  scenario 'shows all jobs for one task', :js do
    jobs = [ create(:job, task: @task), create(:job, task: @task), create(:job, task: @task) ]

    visit tasks_path

    click_link subject_short(@task.subject)
    click_link 'Tiempo dedicado'

    within 'table thead tr' do
      expect(page).to have_content 'Fecha'
      expect(page).to have_content 'Usuario'
      expect(page).to have_content 'Descripción'
      expect(page).to have_content 'Horas'
    end

    within '#jobs' do
      jobs.each do |job|
        within "#job_#{job.id}" do
          expect(page).to have_content I18n.l(job.performed_at, format: :only_date)
          expect(page).to have_content job.user.name
          expect(page).to have_content job.description
          expect(page).to have_content hours_str(job.hours)
        end
      end
    end
  end

  scenario 'shows total job hours for one task', :js do
    jobs = [ create(:job, task: @task), create(:job, task: @task), create(:job, task: @task) ]

    visit tasks_path

    click_link subject_short(@task.subject)
    click_link 'Tiempo dedicado'
    
    expect(page).to have_content total_hours_str(@task.jobs)
  end

  scenario 'create new job for one task', :js do
    visit tasks_path

    click_link subject_short(@task.subject)
    click_link 'Tiempo dedicado'
    click_link 'Añadir tiempo'

    fill_in 'job_performed_at', with: I18n.l(Date.today)
    fill_in 'job_description', with: 'He realizado un trabajo muy interesante'
    fill_in 'job_hours', with: '3.5'
    find('#add_job_button').click
    
    within '#jobs' do
      expect(page).to have_content I18n.l(Date.today)
      expect(page).to have_content user.name
      expect(page).to have_content 'He realizado un trabajo muy interesante'
      expect(page).to have_content hours_str(3.5)
    end
  end

  scenario 'create new job with errors', :js do
    visit tasks_path

    click_link subject_short(@task.subject)
    click_link 'Tiempo dedicado'
    click_link 'Añadir tiempo'
    
    fill_in 'job_hours', with: '0.0'
    find('#add_job_button').click

    expect(page).to have_content 'debe ser mayor que 0'
  end

  scenario 'delete a job', :js do
    jobs = [ create(:job, task: @task), create(:job, task: @task) ]
    job = create(:job, task: @task)

    visit tasks_path
    click_link subject_short(@task.subject)
    click_link 'Tiempo dedicado'

    expect(page).to have_content total_hours_str(@task.jobs)

    find("#job_#{job.id} a.text-danger").click

    expect(page).to have_content total_hours_str(jobs)
  end

end