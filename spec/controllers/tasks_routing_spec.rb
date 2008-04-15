require File.dirname(__FILE__) + '/../spec_helper'

describe TasksController do
  describe "route generation" do

    it "should map { :controller => 'tasks', :action => 'index' } to /tasks" do
      route_for(:controller => "tasks", :action => "index").should == "/tasks"
    end
  
    it "should map { :controller => 'tasks', :action => 'new' } to /tasks/new" do
      route_for(:controller => "tasks", :action => "new").should == "/tasks/new"
    end
  
    it "should map { :controller => 'tasks', :action => 'show', :id => 1 } to /tasks/1" do
      route_for(:controller => "tasks", :action => "show", :id => 1).should == "/tasks/1"
    end
  
    it "should map { :controller => 'tasks', :action => 'edit', :id => 1 } to /tasks/1/edit" do
      route_for(:controller => "tasks", :action => "edit", :id => 1).should == "/tasks/1/edit"
    end
  
    it "should map { :controller => 'tasks', :action => 'update', :id => 1} to /tasks/1" do
      route_for(:controller => "tasks", :action => "update", :id => 1).should == "/tasks/1"
    end
  
    it "should map { :controller => 'tasks', :action => 'destroy', :id => 1} to /tasks/1" do
      route_for(:controller => "tasks", :action => "destroy", :id => 1).should == "/tasks/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'tasks', action => 'index' } from GET /tasks" do
      params_from(:get, "/tasks").should == {:controller => "tasks", :action => "index"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'new' } from GET /tasks/new" do
      params_from(:get, "/tasks/new").should == {:controller => "tasks", :action => "new"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'create' } from POST /tasks" do
      params_from(:post, "/tasks").should == {:controller => "tasks", :action => "create"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'show', id => '1' } from GET /tasks/1" do
      params_from(:get, "/tasks/1").should == {:controller => "tasks", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'edit', id => '1' } from GET /tasks/1;edit" do
      params_from(:get, "/tasks/1/edit").should == {:controller => "tasks", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'update', id => '1' } from PUT /tasks/1" do
      params_from(:put, "/tasks/1").should == {:controller => "tasks", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'tasks', action => 'destroy', id => '1' } from DELETE /tasks/1" do
      params_from(:delete, "/tasks/1").should == {:controller => "tasks", :action => "destroy", :id => "1"}
    end
  end
end