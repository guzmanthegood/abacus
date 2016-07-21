require 'rails_helper'

feature 'Users' do
  let(:user)  {create(:user)}

  before do
    login user
  end

  scenario 'Shows link to users in main page with users count' do
    visit root_path
    expect(page).to have_link 'Usuarios 1'

    users = [create(:user), create(:user), create(:user)]
    visit root_path
    expect(page).to have_link 'Usuarios 4'
  end

  scenario 'Index shows all users' do
    users = [create(:user), create(:user), create(:user)]
    
    visit users_path

    expect(page).to have_content 'Gestión de usuarios'
    expect(page).to have_selector '#users tr.user', count: 4
    users.each do |user|
      within "#user_#{user.id}" do
        expect(page).to have_content user.name
        expect(page).to have_content user.email
      end
    end
  end 

  scenario 'Index shows new user form' do
    visit users_path

    expect(page).to have_content 'Nuevo usuario'
    within '#user-form-body' do
      expect(page).to have_field 'Nombre'
      expect(page).to have_field 'Email'
      expect(page).to have_button 'Crear Usuario'
    end
  end

  scenario 'Index shows new user link', :js do
    visit users_path

    expect(page).to have_link 'Nuevo usuario'
  end

  scenario 'Create without errors', :js do
    visit users_path
    
    expect(page).to have_link 'Usuarios 1'

    fill_in 'Nombre', with: 'Fulanito'
    fill_in 'Email', with: 'fulanito@fulano.com'
    fill_in 'Contraseña', with: '123456'
    fill_in 'Confirmar contraseña', with: '123456'
    click_button 'Crear Usuario'

    expect(page).to have_link 'Usuarios 2'
    within "#users" do
      expect(page).to have_content 'Fulanito'
      expect(page).to have_content 'fulanito@fulano.com'
    end
  end

  scenario 'Create with errors', :js do
    visit users_path
    
    fill_in 'Nombre', with: 'Fulanito'
    fill_in 'Email', with: ''

    click_button 'Crear Usuario'

    within '#user-form-body' do
      expect(page).to have_content 'no puede estar en blanco'
    end
  end

  scenario 'Update without errors', :js do
    users = [create(:user), create(:user), create(:user)]
    user = users.first

    visit users_path
    find("#user_#{user.id}").click

    expect(page).to have_content "Editar usuario ##{user.id}"
    within '#user-form-body' do
      expect(page).to have_field 'Nombre', with: user.name
      expect(page).to have_field 'Email', with: user.email
    end

    fill_in 'Nombre', with: 'Fulanito'
    fill_in 'Email', with: 'fulanito@fulano.com'
    click_button 'Actualizar Usuario'

    within '#user-form-body' do
      expect(page).to have_field 'Nombre', with: 'Fulanito'
      expect(page).to have_field 'Email', with: 'fulanito@fulano.com'
    end

    within "#users" do
      expect(page).to have_content 'Fulanito'
      expect(page).to have_content 'fulanito@fulano.com'
    end
  end

  scenario 'Update with errors', :js do
    user = create(:user)

    visit users_path
    find("#user_#{user.id}").click

    fill_in 'Nombre', with: 'Fulanito'
    fill_in 'Email', with: ''
    click_button 'Actualizar Usuario'

    within '#user-form-body' do
      expect(page).to have_content 'no puede estar en blanco'
    end
  end

  scenario 'Update form shows delete link but not shows in new user form', :js do
    user = create(:user)

    visit users_path
    find("#user_#{user.id}").click

    within '#user-form-body' do
      expect(page).to have_link 'Eliminar usuario'
    end

    click_link 'Nuevo usuario'

    within '#user-form-body' do
      expect(page).to_not have_link 'Eliminar usuario'
    end
  end

  scenario 'Delete', :js do
    users = [create(:user), create(:user), create(:user)]
    user = users.first

    visit users_path
    expect(page).to have_link 'Usuarios 4'
    find("#user_#{user.id}").click

    click_link 'Eliminar usuario'

    expect(page).to have_link 'Usuarios 3'
    within "#users" do
      expect(page).to_not have_content user.name
      expect(page).to_not have_content user.email
    end
  end

end