require 'rails_helper'

feature 'Devise' do
  before do
    ActionMailer::Base.deliveries.clear
  end

  scenario 'existing user can login' do
    user = create(:user)
    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Contraseña', with: user.password
    click_button 'Iniciar sesión'

    within '#layout-notice' do
      expect(page).to have_content('Sesión iniciada.')
    end
  end

  scenario 'non existing user cant login' do
    visit new_user_session_path

    fill_in 'Email', with: 'fulanito@fulano.com'
    fill_in 'Contraseña', with: '123456'
    click_button 'Iniciar sesión'

    within '#layout-notice' do
      expect(page).to have_content('Email o contraseña no válidos.')
    end
  end

  scenario 'loged user can logout', :js do
    user = create_logged_in_user
    visit root_path

    click_link user.name
    click_link 'Cerrar sesión'

    within '#layout-notice' do
      expect(page).to have_content('Sesión finalizada.')
    end
  end

  scenario 'existing user can request his password' do
    user = create(:user)
    visit new_user_password_path
  
    fill_in 'Email', with: user.email
    click_button 'Recuperar contraseña'
    
    within '#layout-notice' do
      expect(page).to have_content('Recibirás un correo con instrucciones sobre cómo resetear tu contraseña en unos pocos minutos.')
      expect(ActionMailer::Base.deliveries.count).to be == 1
    end
  end

  scenario 'existing user can edit his password clicking in email instructions' do
    # Skip
  end

end