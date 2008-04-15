require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tasks/index.html.erb" do
  include TasksHelper
  
  before(:each) do
    task_98 = mock_model(Task)
    task_98.should_receive(:project_id).and_return("1")
    task_98.should_receive(:name).and_return("MyString")
    task_99 = mock_model(Task)
    task_99.should_receive(:project_id).and_return("1")
    task_99.should_receive(:name).and_return("MyString")

    assigns[:tasks] = [task_98, task_99]
  end

  it "should render list of tasks" do
    render "/tasks/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

