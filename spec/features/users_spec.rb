require 'rails_helper'

feature 'Users' do

  before do
    #page.driver.resize_window(1920, 1080)
  end

  feature 'Index' do
    
    scenario 'shows new user form' do
      visit users_path

      fill_in 'Nombre', with: 'manuel'
      
      expect(page).to have_content('Nuevo usuario')
      within("#user-form-body") do
        expect(page).to have_field('Nombre')
        expect(page).to have_field('Email')
        expect(page).to have_button('Crear Usuario')
      end
    end

  end
end