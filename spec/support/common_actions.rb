module CommonActions
  def page!
    screenshot_and_save_page
  end

  def fill_in_wysihtml5(selector, text)
    page.execute_script %Q{ $('#{selector}').data("wysihtml5").editor.setValue('#{text}') }
  end

  def wysihtml5_value(selector)
    page.evaluate_script %Q{ $('#{selector}').data("wysihtml5").editor.getValue() }
  end
end