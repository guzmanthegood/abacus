module TasksHelper
  def options_for_task_types()
    options_for_select([['Tarea', 'task'], ['Funcionalidad', 'feature'], ['Error', 'bug']])
  end
end