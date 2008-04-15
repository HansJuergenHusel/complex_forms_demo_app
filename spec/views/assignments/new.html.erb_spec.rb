require File.dirname(__FILE__) + '/../../spec_helper'

describe "/assignments/new.html.erb" do
  include AssignmentsHelper
  
  before(:each) do
    @assignment = mock_model(Assignment)
    @assignment.stub!(:new_record?).and_return(true)
    @assignment.stub!(:employee_id).and_return("1")
    @assignment.stub!(:project_id).and_return("1")
    @assignment.stub!(:title).and_return("MyString")
    assigns[:assignment] = @assignment
  end

  it "should render new form" do
    render "/assignments/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", assignments_path) do
      with_tag("input#assignment_title[name=?]", "assignment[title]")
    end
  end
end


