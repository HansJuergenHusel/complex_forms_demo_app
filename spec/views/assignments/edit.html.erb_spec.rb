require File.dirname(__FILE__) + '/../../spec_helper'

describe "/assignments/edit.html.erb" do
  include AssignmentsHelper
  
  before do
    @assignment = mock_model(Assignment)
    @assignment.stub!(:employee_id).and_return("1")
    @assignment.stub!(:project_id).and_return("1")
    @assignment.stub!(:title).and_return("MyString")
    assigns[:assignment] = @assignment
  end

  it "should render edit form" do
    render "/assignments/edit.html.erb"
    
    response.should have_tag("form[action=#{assignment_path(@assignment)}][method=post]") do
      with_tag('input#assignment_title[name=?]', "assignment[title]")
    end
  end
end


