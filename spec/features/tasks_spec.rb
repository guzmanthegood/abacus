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

    scenario 'shows all status menu links' do
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

  context 'Create' do
    before do
      user.update(current_project: project)
    end

    scenario 'new task', :js do
      visit tasks_path

      expect(page).to have_link 'Todas 0'

      click_link 'Nueva tarea'

      select 'Error', from: 'Tipo'
      select 'Desarrollo', from: 'Estado'
      select '20%', from: 'Progreso'
      fill_in 'Asunto', with: 'Un asunto para una tarea'
      fill_in_wysihtml5 '#task_description', 'Esto es una tarea muy importante por que....'
      click_button 'Guardar'

      expect(page).to have_link 'Todas 1'
      expect(page).to have_link 'Desarrollo 1'
      expect(page).to have_select 'Tipo', selected: 'Error'
      expect(page).to have_select 'Estado', selected: 'Desarrollo'
      expect(page).to have_select 'Progreso', selected: '20%'
      expect(page).to have_field 'Asunto', with: 'Un asunto para una tarea'
      expect(wysihtml5_value('#task_description')).to eq('Esto es una tarea muy importante por que....')
    end

    scenario 'new task with errors', :js do
      visit tasks_path

      expect(page).to have_link 'Todas 0'

      click_link 'Nueva tarea'
      click_button 'Guardar'

      expect(page).to have_content 'no puede estar en blanco'
      expect(page).to have_link 'Todas 0'
    end
  end

  context 'Update' do
    before do
      user.update(current_project: project)
      @task = create(:task, project: project)
    end

    scenario 'edit task', :js do
      visit tasks_path

      expect(page).to have_link 'Todas 1'
      expect(page).to have_link "#{@task.status_i18n} 1"

      click_link subject_short(@task.subject)

      expect(page).to have_select 'Tipo', selected: @task.task_type_i18n
      expect(page).to have_select 'Estado', selected: @task.status_i18n
      expect(page).to have_select 'Progreso', selected: "#{@task.progress}%"
      expect(page).to have_field 'Asunto', with: @task.subject
      expect(wysihtml5_value('#task_description')).to eq(@task.description)

      select 'Error', from: 'Tipo'
      select 'Desarrollo', from: 'Estado'
      select '20%', from: 'Progreso'
      fill_in 'Asunto', with: 'Un asunto para una tarea'
      fill_in_wysihtml5 '#task_description', 'Esto es una tarea muy importante por que....'
      click_button 'Guardar'

      expect(page).to have_link 'Todas 1'
      expect(page).to have_link "Desarrollo 1"
      expect(page).to have_select 'Tipo', selected: 'Error'
      expect(page).to have_select 'Estado', selected: 'Desarrollo'
      expect(page).to have_select 'Progreso', selected: '20%'
      expect(page).to have_field 'Asunto', with: 'Un asunto para una tarea'
      expect(wysihtml5_value('#task_description')).to eq('Esto es una tarea muy importante por que....')
    end

    scenario 'edit task with errors', :js do
      visit tasks_path

      click_link subject_short(@task.subject)

      fill_in 'Asunto', with: ''
      click_button 'Guardar'

      expect(page).to have_content 'no puede estar en blanco'
    end
  end

  context 'Nav buttons' do
    before do
      user.update(current_project: project)
      sample_user = create(:user)

      @tasks = [  create(:task, project: project, author: sample_user),
                  create(:task, project: project, author: sample_user),
                  create(:task, project: project, author: sample_user),
                  create(:task, project: project, author: sample_user),
                  create(:task, project: project, author: sample_user)  ]
    end

    scenario 'can go forward and backward in the tasks', :js do
      first = @tasks.shift
      last = @tasks.pop

      visit tasks_path

      click_link subject_short(first.subject)
      
      expect(page).to have_content("Editar tarea ##{first.id}")
      expect(page).not_to have_selector 'a.btn i.fa-chevron-left'
      expect(page).to have_selector 'a.btn i.fa-chevron-right'
      
      @tasks.each do |task|
        find('a.btn i.fa-chevron-right').click
        expect(page).to have_content("Editar tarea ##{task.id}")
        expect(page).to have_selector 'a.btn i.fa-chevron-left'
        expect(page).to have_selector 'a.btn i.fa-chevron-right'
      end

      find('a.btn i.fa-chevron-right').click
      expect(page).to have_content("Editar tarea ##{last.id}")
      expect(page).to have_selector 'a.btn i.fa-chevron-left'
      expect(page).not_to have_selector 'a.btn i.fa-chevron-right'

      @tasks.reverse_each do |task|
        find('a.btn i.fa-chevron-left').click
        expect(page).to have_content("Editar tarea ##{task.id}")
        expect(page).to have_selector 'a.btn i.fa-chevron-left'
        expect(page).to have_selector 'a.btn i.fa-chevron-right'
      end

      find('a.btn i.fa-chevron-left').click
      expect(page).to have_content("Editar tarea ##{first.id}")
      expect(page).not_to have_selector 'a.btn i.fa-chevron-left'
      expect(page).to have_selector 'a.btn i.fa-chevron-right'
    end
  end

  context 'Status filter' do
    before do
      user.update(current_project: project)
      sample_user = create(:user)

      @fresh_tasks =  [ create(:task, project: project, author: sample_user, status: :fresh), 
                        create(:task, project: project, author: sample_user, status: :fresh), 
                        create(:task, project: project, author: sample_user, status: :fresh),
                        create(:task, project: project, author: sample_user, status: :fresh)]
      @todo_tasks =   [ create(:task, project: project, author: sample_user, status: :todo), 
                        create(:task, project: project, author: sample_user, status: :todo)]
      @deploy_tasks = [ create(:task, project: project, author: sample_user, status: :deploy), 
                        create(:task, project: project, author: sample_user, status: :deploy), 
                        create(:task, project: project, author: sample_user, status: :deploy)]
      @done_tasks =   [ create(:task, project: project, author: sample_user, status: :done), 
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

    scenario 'shows no results when click in empty taks status', :js do
      visit tasks_path

      click_link "Desarrollo 0"

      expect(page).to have_content 'No se encontraron resultados'
      expect(page).not_to have_link subject_short(@todo_tasks.first.subject)
      expect(page).not_to have_link subject_short(@fresh_tasks.first.subject)
      expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
      expect(page).not_to have_link subject_short(@done_tasks.first.subject)
    end

    scenario 'remember user status selection when turn back from task form', :js do
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

    scenario 'click on status row label filter by status', :js do
      visit tasks_path

      within '#tasks-body' do
        within "#task_#{@todo_tasks.first.id}" do
          click_link 'Pendiente'
        end
      end

      expect(page).to have_selector 'ul.status-menu li.todo.active'
      expect(page).to have_link subject_short(@todo_tasks.first.subject)
      expect(page).not_to have_link subject_short(@fresh_tasks.first.subject)
      expect(page).not_to have_link subject_short(@deploy_tasks.first.subject)
      expect(page).not_to have_link subject_short(@done_tasks.first.subject)
    end
  end
end