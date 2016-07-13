require 'rails_helper'

feature 'Projects' do
  let(:user)  {create(:user)}

  before do
    page.driver.resize_window(1920, 1080) if js_active?
    login user
  end

  scenario 'Shows link to projects in main page with projects count' do
    visit root_path
    expect(page).to have_link 'Proyectos 0'

    projects = [create(:project), create(:project), create(:project)]
    visit root_path
    expect(page).to have_link 'Proyectos 3'
  end

  scenario 'Index shows all projects' do
    projects = [create(:project), create(:project), create(:project)]
    
    visit projects_path

    expect(page).to have_content 'Gestión de proyectos'
    expect(page).to have_selector '#projects tr.project', count: 3
    projects.each do |project|
      within "#project_#{project.id}" do
        expect(page).to have_content project.name
      end
    end
  end 

  scenario 'Index shows new project form' do
    visit projects_path

    expect(page).to have_content 'Nuevo proyecto'
    within '#project-form-body' do
      expect(page).to have_field 'Nombre'
      expect(page).to have_field 'Web'
      expect(page).to have_field 'Descripción'
      expect(page).to have_button 'Crear Proyecto'
    end
  end

  scenario 'Index shows new project link', :js do
    visit projects_path

    expect(page).to have_link 'Nuevo proyecto'
  end

  scenario 'Create without errors', :js do
    visit projects_path

    expect(page).to have_link 'Proyectos 0'
    
    fill_in 'Nombre', with: 'Fulanito Industries'
    fill_in 'Web', with: 'http://fulanitoindustries.com'
    fill_in 'Descripción', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing'
    click_button 'Crear Proyecto'

    expect(page).to have_link 'Proyectos 1'
    within "#projects" do
      expect(page).to have_content 'Fulanito Industries'
    end
  end

  scenario 'Create with errors', :js do
    visit projects_path
    
    fill_in 'Nombre', with: ''

    click_button 'Crear Proyecto'

    within '#project-form-body' do
      expect(page).to have_content 'no puede estar en blanco'
    end
  end

  scenario 'Update without errors', :js do
    projects = [create(:project), create(:project), create(:project)]
    project = projects.first

    visit projects_path
    find("#project_#{project.id}").click

    expect(page).to have_content "Editar proyecto ##{project.id}"
    within '#project-form-body' do
      expect(page).to have_field 'Nombre', with: project.name
      expect(page).to have_field 'Web', with: project.web
      expect(page).to have_field 'Descripción', with: project.description
    end

    fill_in 'Nombre', with: 'Fulanito Industries'
    fill_in 'Web', with: 'http://fulanitoindustries.com'
    fill_in 'Descripción', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing'
    click_button 'Actualizar Proyecto'

    within '#project-form-body' do
      expect(page).to have_field 'Nombre', with: 'Fulanito Industries'
      expect(page).to have_field 'Web', with: 'http://fulanitoindustries.com'
      expect(page).to have_field 'Descripción', with: 'Lorem ipsum dolor sit amet, consectetur adipiscing'
    end

    within "#projects" do
      expect(page).to have_content 'Fulanito Industries'
    end
  end

  scenario 'Update with errors', :js do
    project = create(:project)

    visit projects_path
    find("#project_#{project.id}").click

    fill_in 'Nombre', with: ''
    click_button 'Actualizar Proyecto'

    within '#project-form-body' do
      expect(page).to have_content 'no puede estar en blanco'
    end
  end

  scenario 'Update form shows delete link but not shows in new project form', :js do
    project = create(:project)

    visit projects_path
    find("#project_#{project.id}").click

    within '#project-form-body' do
      expect(page).to have_link 'Eliminar proyecto'
    end

    click_link 'Nuevo proyecto'

    within '#project-form-body' do
      expect(page).to_not have_link 'Eliminar proyecto'
    end
  end

  scenario 'Delete', :js do
    projects = [create(:project), create(:project), create(:project)]
    project = projects.first

    visit projects_path
    expect(page).to have_link 'Proyectos 3'
    find("#project_#{project.id}").click

    click_link 'Eliminar proyecto'

    expect(page).to have_link 'Proyectos 2'
    within "#projects" do
      expect(page).to_not have_content project.name
    end
  end

end