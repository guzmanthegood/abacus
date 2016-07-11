module CommonActions
  def js_active?
    Capybara.javascript_driver == Capybara.current_driver
  end

  def page!
    screenshot_and_save_page
  end
end