require 'rails_helper'

feature 'Users page' do

  before do
    page.driver.resize_window(1920, 1080)
  end

  scenario 'should render by default new user form', js: true do
    visit users_path
    expect(page).to have_content('Nuevo usuario')
  end
end