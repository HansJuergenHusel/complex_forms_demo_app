require File.dirname(__FILE__) + '/../../spec_helper'

describe "/assignments/index.html.erb" do
  include AssignmentsHelper
  
  before(:each) do
    assignment_98 = mock_model(Assignment)
    assignment_98.should_receive(:employee_id).and_return("1")
    assignment_98.should_receive(:project_id).and_return("1")
    assignment_98.should_receive(:title).and_return("MyString")
    assignment_99 = mock_model(Assignment)
    assignment_99.should_receive(:employee_id).and_return("1")
    assignment_99.should_receive(:project_id).and_return("1")
    assignment_99.should_receive(:title).and_return("MyString")

    assigns[:assignments] = [assignment_98, assignment_99]
  end

  it "should render list of assignments" do
    render "/assignments/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

