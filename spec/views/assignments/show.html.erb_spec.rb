require File.dirname(__FILE__) + '/../../spec_helper'

describe "/assignments/show.html.erb" do
  include AssignmentsHelper
  
  before(:each) do
    @assignment = mock_model(Assignment)
    @assignment.stub!(:employee_id).and_return("1")
    @assignment.stub!(:project_id).and_return("1")
    @assignment.stub!(:title).and_return("MyString")

    assigns[:assignment] = @assignment
  end

  it "should render attributes in <p>" do
    render "/assignments/show.html.erb"
    response.should have_text(/MyString/)
  end
end

