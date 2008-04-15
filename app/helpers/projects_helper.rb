module ProjectsHelper
  def add_task_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :tasks, :partial => 'task', :object => Task.new 
    end 
  end 

  def add_assignment_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :assignments, :partial => 'assignment', :object => Assignment.new 
    end 
  end

end
