require File.dirname(__FILE__) + '/../../spec_helper'

describe "/categorizations/edit.html.erb" do
  include CategorizationsHelper
  
  before do
    @categorization = mock_model(Categorization)
    assigns[:categorization] = @categorization
  end

  it "should render edit form" do
    render "/categorizations/edit.html.erb"
    
    response.should have_tag("form[action=#{categorization_path(@categorization)}][method=post]") do
    end
  end
end


