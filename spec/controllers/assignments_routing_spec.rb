require File.dirname(__FILE__) + '/../spec_helper'

describe AssignmentsController do
  describe "route generation" do

    it "should map { :controller => 'assignments', :action => 'index' } to /assignments" do
      route_for(:controller => "assignments", :action => "index").should == "/assignments"
    end
  
    it "should map { :controller => 'assignments', :action => 'new' } to /assignments/new" do
      route_for(:controller => "assignments", :action => "new").should == "/assignments/new"
    end
  
    it "should map { :controller => 'assignments', :action => 'show', :id => 1 } to /assignments/1" do
      route_for(:controller => "assignments", :action => "show", :id => 1).should == "/assignments/1"
    end
  
    it "should map { :controller => 'assignments', :action => 'edit', :id => 1 } to /assignments/1/edit" do
      route_for(:controller => "assignments", :action => "edit", :id => 1).should == "/assignments/1/edit"
    end
  
    it "should map { :controller => 'assignments', :action => 'update', :id => 1} to /assignments/1" do
      route_for(:controller => "assignments", :action => "update", :id => 1).should == "/assignments/1"
    end
  
    it "should map { :controller => 'assignments', :action => 'destroy', :id => 1} to /assignments/1" do
      route_for(:controller => "assignments", :action => "destroy", :id => 1).should == "/assignments/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'assignments', action => 'index' } from GET /assignments" do
      params_from(:get, "/assignments").should == {:controller => "assignments", :action => "index"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'new' } from GET /assignments/new" do
      params_from(:get, "/assignments/new").should == {:controller => "assignments", :action => "new"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'create' } from POST /assignments" do
      params_from(:post, "/assignments").should == {:controller => "assignments", :action => "create"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'show', id => '1' } from GET /assignments/1" do
      params_from(:get, "/assignments/1").should == {:controller => "assignments", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'edit', id => '1' } from GET /assignments/1;edit" do
      params_from(:get, "/assignments/1/edit").should == {:controller => "assignments", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'update', id => '1' } from PUT /assignments/1" do
      params_from(:put, "/assignments/1").should == {:controller => "assignments", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'assignments', action => 'destroy', id => '1' } from DELETE /assignments/1" do
      params_from(:delete, "/assignments/1").should == {:controller => "assignments", :action => "destroy", :id => "1"}
    end
  end
end