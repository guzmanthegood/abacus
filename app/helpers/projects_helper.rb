module ProjectsHelper
  def options_for_projects
    Project.all.collect {|p| [ p.name, p.id ] }
  end
end