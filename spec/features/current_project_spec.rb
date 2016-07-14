require 'rails_helper'

feature 'Current project' do
  let(:user)  {create(:user)}

  before do
    page.driver.resize_window(1920, 1080) if js_active?
    login user
  end

  scenario 'sidebar not shows current project links' do
  	visit root_path

  	expect(page).to_not have_content 'GESTIÓN DEL PROYECTO'
  	expect(page).to_not have_link 'Visión general'
  	expect(page).to_not have_link 'Tareas 0'
  	expect(page).to_not have_link 'Facturas 0'
  	expect(page).to_not have_link 'Documentación'
  	expect(page).to_not have_link 'Configuración'
  end

  scenario 'sidebar shows current project links when a project is selected', :js do
  	project = create(:project)
  	
  	visit root_path
  	select project.name, from: 'current_project_select'

  	expect(page).to have_content 'GESTIÓN DEL PROYECTO'
  	expect(page).to have_link 'Visión general'
  	expect(page).to have_link 'Tareas 0'
  	expect(page).to have_link 'Facturas 0'
  	expect(page).to have_link 'Documentación'
  	expect(page).to have_link 'Configuración'
  end  

  scenario 'user can select current project from navbar select', :js do
  	projects = [create(:project), create(:project), create(:project)]
  	project = projects.first

  	visit root_path

  	select project.name, from: 'current_project_select'

		within '#layout-notice' do
      expect(page).to have_content "Proyecto #{project.name} seleccionado"
    end
  end

	scenario 'user can select current project from projects index', :js do
  	projects = [create(:project), create(:project), create(:project)]
  	project = projects.first

  	visit projects_path

  	find("#project_#{project.id}").click
  	click_link 'Seleccionar proyecto'

		within '#layout-notice' do
      expect(page).to have_content "Proyecto #{project.name} seleccionado"
    end
  end


end