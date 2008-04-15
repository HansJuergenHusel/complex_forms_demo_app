require File.dirname(__FILE__) + '/../spec_helper'

describe Categorization do
  before(:each) do
    @categorization = Categorization.new
  end

  it "should be valid" do
    @categorization.should be_valid
  end
end
