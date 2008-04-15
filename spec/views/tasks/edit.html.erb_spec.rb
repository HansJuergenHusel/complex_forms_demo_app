require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tasks/edit.html.erb" do
  include TasksHelper
  
  before do
    @task = mock_model(Task)
    @task.stub!(:project_id).and_return("1")
    @task.stub!(:name).and_return("MyString")
    assigns[:task] = @task
  end

  it "should render edit form" do
    render "/tasks/edit.html.erb"
    
    response.should have_tag("form[action=#{task_path(@task)}][method=post]") do
      with_tag('input#task_name[name=?]', "task[name]")
    end
  end
end


