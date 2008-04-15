require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tasks/new.html.erb" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task)
    @task.stub!(:new_record?).and_return(true)
    @task.stub!(:project_id).and_return("1")
    @task.stub!(:name).and_return("MyString")
    assigns[:task] = @task
  end

  it "should render new form" do
    render "/tasks/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", tasks_path) do
      with_tag("input#task_name[name=?]", "task[name]")
    end
  end
end


