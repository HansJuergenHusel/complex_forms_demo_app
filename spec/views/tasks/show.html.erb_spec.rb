require File.dirname(__FILE__) + '/../../spec_helper'

describe "/tasks/show.html.erb" do
  include TasksHelper
  
  before(:each) do
    @task = mock_model(Task)
    @task.stub!(:project_id).and_return("1")
    @task.stub!(:name).and_return("MyString")

    assigns[:task] = @task
  end

  it "should render attributes in <p>" do
    render "/tasks/show.html.erb"
    response.should have_text(/MyString/)
  end
end

