require File.dirname(__FILE__) + '/../../spec_helper'

describe "/categorizations/new.html.erb" do
  include CategorizationsHelper
  
  before(:each) do
    @categorization = mock_model(Categorization)
    @categorization.stub!(:new_record?).and_return(true)
    assigns[:categorization] = @categorization
  end

  it "should render new form" do
    render "/categorizations/new.html.erb"
    
    response.should have_tag("form[action=?][method=post]", categorizations_path) do
    end
  end
end


