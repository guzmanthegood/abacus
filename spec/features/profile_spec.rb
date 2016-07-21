require 'rails_helper'

feature 'Profile' do
  let(:user)  {create(:user)}

  before do
    login user
  end

  scenario 'link to my account in navbar menu' do
    visit root_path

    click_link user.name

    within "li.dropdown.user" do
      expect(page).to have_link 'Mi cuenta'
    end
  end

  scenario 'link to my account in sidebar', :js do
    visit root_path

    expect(page).to have_link 'Mi cuenta'
  end

  scenario 'shows user basic info' do
    visit profile_path
  
    within "h3.profile-username" do
      expect(page).to have_content user.name
    end
    expect(page).to have_content "Conexiones totales: #{user.sign_in_count}"
    expect(page).to have_content "Última conexión: #{I18n.l(user.last_sign_in_at, format: :long)}"
    expect(page).to have_link 'Borrar mi cuenta'
  end

  scenario 'update user account without password' do
    visit profile_path

    expect(page).to have_content "Editar datos personales"
    within 'form.edit_user' do
      expect(page).to have_field 'Nombre', with: user.name
      expect(page).to have_field 'Email', with: user.email
    end

    fill_in 'Nombre', with: 'Fulanito'
    fill_in 'Email', with: 'fulanito@fulano.com'
    click_button 'Actualizar Usuario'

    within '#layout-notice' do
      expect(page).to have_content 'Datos de usuario modificados correctamente'
    end
  end

  scenario 'update user password' do
    visit profile_path

    fill_in 'Contraseña', with: '123456'
    fill_in 'Confirmar contraseña', with: '123456'
    click_button 'Actualizar Usuario'

    within '#layout-notice' do
      expect(page).to have_content 'Tienes que iniciar sesión o registrarte para poder continuar.'
    end

    fill_in 'Email', with: user.email
    fill_in 'Contraseña', with: '123456'
    click_button 'Iniciar sesión'

    within '#layout-notice' do
      expect(page).to have_content 'Sesión iniciada.'
    end
  end

  scenario 'cancel account' do
    visit profile_path

    click_link 'Borrar mi cuenta'

    within '#layout-notice' do
      expect(page).to have_content 'Su usuario ha sido eliminado'
    end
  end

end