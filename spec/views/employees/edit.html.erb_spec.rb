require File.dirname(__FILE__) + '/../../spec_helper'

describe "/employees/edit.html.erb" do
  include EmployeesHelper
  
  before do
    @employee = mock_model(Employee)
    @employee.stub!(:name).and_return("MyString")
    assigns[:employee] = @employee
  end

  it "should render edit form" do
    render "/employees/edit.html.erb"
    
    response.should have_tag("form[action=#{employee_path(@employee)}][method=post]") do
      with_tag('input#employee_name[name=?]', "employee[name]")
    end
  end
end


