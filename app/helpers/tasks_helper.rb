module TasksHelper
  def options_for_task_types(selected)
    options_for_select([['Tarea', 'task'], ['Funcionalidad', 'feature'], ['Error', 'bug']], selected)
  end

  def options_for_task_progress(selected)
    options_for_select((0..100).step(10).map{|i| ["#{i}%",i]}, selected)
  end

  def subject_short(subject)
  	str = subject[0..45]
  	str << " ..." if subject.length > 45
  	str
  end

  def progress_bar_color(progress)
  	if progress.between?(0, 49)
  		"warning"
  	elsif progress.between?(50, 99)
  		"primary"	
  	else
  		"success"
  	end
  end

  def task_type_label(task)
  	if task.bug?
  		"<span class='label label-danger'><i class='fa fa-bug'></i></span>".html_safe
  	elsif task.task?
  		"<span class='label bg-purple'><i class='fa fa-pencil'></i></span>".html_safe
  	end
  end

end