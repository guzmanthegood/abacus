module TasksHelper
  def options_for_task_types()
    options_for_select([['Tarea', 'task'], ['Funcionalidad', 'feature'], ['Error', 'bug']])
  end

  def subject_short(subject)
  	str = subject[0..45]
  	str << " ..." if subject.length > 45
  	str
  end

  def progress_bar_color(progress)
  	if progress.between?(0, 32)
  		"danger" 
  	elsif progress.between?(33, 62)
  		"warning" 
  	elsif progress.between?(62, 99)
  		"primary"	
  	else
  		"success"
  	end
  end

  def task_type_label(task_type)
  	if task_type == "bug"
  		"<span class='label label-danger'>Error</span>".html_safe
  	elsif task_type == "task"
  		"<span class='label label-primary'>Task</span>".html_safe
  	elsif task_type == "feature"
  		"<span class='label label-info'>Feature</span>".html_safe
  	end
  end
end