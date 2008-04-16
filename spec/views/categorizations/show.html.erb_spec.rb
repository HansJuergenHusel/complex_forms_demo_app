require File.dirname(__FILE__) + '/../../spec_helper'

describe "/categorizations/show.html.erb" do
  include CategorizationsHelper
  
  before(:each) do
    @categorization = mock_model(Categorization)

    assigns[:categorization] = @categorization
  end

  it "should render attributes in <p>" do
    render "/categorizations/show.html.erb"
  end
end

