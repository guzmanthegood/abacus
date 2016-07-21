require 'rails_helper'
include TasksHelper

feature 'Tasks' do
  let(:user)    {create(:user)}
  let!(:project) {create(:project)}

  before do
    login user
  end

  scenario 'not shows sidebar tasks link when not project selected' do
    visit root_path

    expect(page).not_to have_link 'Tareas 0'
  end

  scenario 'shows sidebar link when project is selected', :js do
    visit root_path

    select project.name, from: 'current_project_select'

    expect(page).to have_link 'Tareas 0'
  end

  scenario 'shows sidebar link with task count label' do
    [ create(:task, project: project), create(:task, project: project), 
      create(:task, project: project), create(:task, project: project) ]
    
    user.update(current_project: project)

    visit root_path

    expect(page).to have_link 'Tareas 4'
  end

  context 'Index' do
    before do
      user.update(current_project: project)
    end

    scenario 'shows new task button link' do
      visit tasks_path

      expect(page).to have_link 'Nueva tarea'
    end

    scenario 'shows status menu links' do
      visit tasks_path

      within 'ul.status-menu' do
        expect(page).to have_link "Todas 0"
        Task.statuses_i18n.each do |label, key|
          expect(page).to have_link "#{label} 0"
        end
      end
    end

    scenario 'shows all project tasks' do
      tasks = [ create(:task, project: project), create(:task, project: project), 
                create(:task, project: project), create(:task, project: project) ]

      visit tasks_path

      within '#tasks-body' do
        tasks.each do |task|
          within "#task_#{task.id}" do
            expect(page).to have_content task.id
            expect(page).to have_selector "span.label.task-bg-#{task.task_type}"
            expect(page).to have_link I18n.t "task_status.#{task.status}"
            expect(page).to have_link subject_short(task.subject)
            expect(page).to have_content (task.progress == 100 ? 99 : task.progress)
            expect(page).to have_content I18n.l (task.created_at), format: :table
          end
        end
      end
    end
  end

  context 'Status filter' do
    before do
      user.update(current_project: project)
      sample_user = create(:user)

      @fresh_tasks =   [ create(:task, project: project, author: sample_user, status: :fresh), 
                        create(:task, project: project, author: sample_user, status: :fresh), 
                        create(:task, project: project, author: sample_user, status: :fresh),
                        create(:task, project: project, author: sample_user, status: :fresh)]
      @todo_tasks =    [ create(:task, project: project, author: sample_user, status: :todo), 
                        create(:task, project: project, author: sample_user, status: :todo)]
      @deploy_tasks =  [ create(:task, project: project, author: sample_user, status: :deploy), 
                        create(:task, project: project, author: sample_user, status: :deploy), 
                        create(:task, project: project, author: sample_user, status: :deploy)]
      @done_tasks =    [ create(:task, project: project, author: sample_user, status: :done), 
                        create(:task, project: project, author: sample_user, status: :done)]
    end

    scenario 'shows filtered tasks using status menu', :js do
      visit tasks_path

      within 'ul.status-menu' do
        expect(page).to have_link "Todas #{Task.project(project).count}"
        expect(page).to have_link "Deploy #{@deploy_tasks.count}"
        expect(page).to have_link "Resuelta #{@done_tasks.count}"
      end

      click_link "Nueva #{@fresh_tasks.count}"

      within '#tasks-body' do
        @fresh_tasks.each do |task|
          within "#task_#{task.id}" do
            expect(page).to have_link I18n.t "task_status.#{task.status}"
            expect(page).to have_link subject_short(task.subject)
          end
        end
        expect(page).not_to have_link subject_short(@todo_tasks.first.subject)
        expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
        expect(page).not_to have_link subject_short(@done_tasks.first.subject)
      end

      click_link "Pendiente #{@todo_tasks.count}"

      within '#tasks-body' do
        @todo_tasks.each do |task|
          within "#task_#{task.id}" do
            expect(page).to have_link I18n.t "task_status.#{task.status}"
            expect(page).to have_link subject_short(task.subject)
          end
        end
        expect(page).not_to have_link subject_short(@fresh_tasks.first.subject)
        expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
        expect(page).not_to have_link subject_short(@done_tasks.first.subject)
      end

      # ...

    end

    scenario 'shows no results when click in empty status', :js do
      visit tasks_path

      click_link "Desarrollo 0"

      expect(page).to have_content 'No se encontraron resultados'
      expect(page).not_to have_link subject_short(@todo_tasks.first.subject)
      expect(page).not_to have_link subject_short(@fresh_tasks.first.subject)
      expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
      expect(page).not_to have_link subject_short(@done_tasks.first.subject)
    end

    scenario 'index remember user status selection when turn back from task form', :js do
      visit tasks_path

      click_link "Pendiente #{@todo_tasks.count}"
      click_link subject_short(@todo_tasks.first.subject)

      click_link 'Volver'

      expect(page).to have_selector 'ul.status-menu li.todo.active'
      expect(page).to have_link subject_short(@todo_tasks.first.subject)
      expect(page).not_to have_link subject_short(@fresh_tasks.first.subject)
      expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
      expect(page).not_to have_link subject_short(@done_tasks.first.subject)
    end

  end
end