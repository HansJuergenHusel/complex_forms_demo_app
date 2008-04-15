require File.dirname(__FILE__) + '/../../spec_helper'

describe "/employees/index.html.erb" do
  include EmployeesHelper
  
  before(:each) do
    employee_98 = mock_model(Employee)
    employee_98.should_receive(:name).and_return("MyString")
    employee_99 = mock_model(Employee)
    employee_99.should_receive(:name).and_return("MyString")

    assigns[:employees] = [employee_98, employee_99]
  end

  it "should render list of employees" do
    render "/employees/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
  end
end

