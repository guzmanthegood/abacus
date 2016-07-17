module TasksHelper
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

  def task_status_icon(status)
    if status[1] == "fresh"
      "fa-inbox"
    elsif status[1] == "todo"
      "fa-clock-o"
    elsif status[1] == "plan"
      "fa-calendar"
    elsif status[1] == "develop"
      "fa-pencil"
    elsif status[1] == "testing"
      "fa-umbrella"
    elsif status[1] == "deploy"
      "fa-rocket"
    elsif status[1] == "done"
      "fa-trophy"
    else
      "fa-trash-o"
    end
  end

  def task_status_class(status)
    if status[1] == "fresh"
      "bg-yellow"
    elsif status[1] == "todo"
      "bg-orange"
    elsif status[1] == "plan"
      "bg-teal"
    elsif status[1] == "develop"
      "bg-blue"
    elsif status[1] == "testing"
      "bg-purple"
    elsif status[1] == "deploy"
      "bg-maroon"
    elsif status[1] == "done"
      "bg-green"
    else
      "bg-red"
    end
  end

end