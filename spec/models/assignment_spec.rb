require File.dirname(__FILE__) + '/../spec_helper'

describe Assignment do
  before(:each) do
    @assignment = Assignment.new
  end

  it "should be valid" do
    @assignment.should be_valid
  end
end
