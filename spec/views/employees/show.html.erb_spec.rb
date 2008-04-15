require File.dirname(__FILE__) + '/../../spec_helper'

describe "/employees/show.html.erb" do
  include EmployeesHelper
  
  before(:each) do
    @employee = mock_model(Employee)
    @employee.stub!(:name).and_return("MyString")

    assigns[:employee] = @employee
  end

  it "should render attributes in <p>" do
    render "/employees/show.html.erb"
    response.should have_text(/MyString/)
  end
end

