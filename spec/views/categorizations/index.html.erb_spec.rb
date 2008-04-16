require File.dirname(__FILE__) + '/../../spec_helper'

describe "/categorizations/index.html.erb" do
  include CategorizationsHelper
  
  before(:each) do
    categorization_98 = mock_model(Categorization)
    categorization_99 = mock_model(Categorization)

    assigns[:categorizations] = [categorization_98, categorization_99]
  end

  it "should render list of categorizations" do
    render "/categorizations/index.html.erb"
  end
end

