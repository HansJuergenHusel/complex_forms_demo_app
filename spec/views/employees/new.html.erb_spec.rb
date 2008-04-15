require File.dirname(__FILE__) + '/../../spec_helper'

describe "/employees/new.html.erb" do
  include EmployeesHelper
  
  before(:each) do
    @employee = mock_model(Employee)
    @employee.stub!(:new_record?).and_return(true)
    @employee.stub!(:name).and_return("MyString")
    assigns[:employee] = @employee
  end

  it "should render new form" do
    render "/employees/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", employees_path) do
      with_tag("input#employee_name[name=?]", "employee[name]")
    end
  end
end


