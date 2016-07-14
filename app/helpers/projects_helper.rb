module ProjectsHelper
  def options_for_projects(project)
  	id = project.present? ? project.id : nil
    options_for_select(Project.all.collect {|p| [ p.name, p.id ] }, id)
  end
end