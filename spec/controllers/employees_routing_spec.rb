require File.dirname(__FILE__) + '/../spec_helper'

describe EmployeesController do
  describe "route generation" do

    it "should map { :controller => 'employees', :action => 'index' } to /employees" do
      route_for(:controller => "employees", :action => "index").should == "/employees"
    end
  
    it "should map { :controller => 'employees', :action => 'new' } to /employees/new" do
      route_for(:controller => "employees", :action => "new").should == "/employees/new"
    end
  
    it "should map { :controller => 'employees', :action => 'show', :id => 1 } to /employees/1" do
      route_for(:controller => "employees", :action => "show", :id => 1).should == "/employees/1"
    end
  
    it "should map { :controller => 'employees', :action => 'edit', :id => 1 } to /employees/1/edit" do
      route_for(:controller => "employees", :action => "edit", :id => 1).should == "/employees/1/edit"
    end
  
    it "should map { :controller => 'employees', :action => 'update', :id => 1} to /employees/1" do
      route_for(:controller => "employees", :action => "update", :id => 1).should == "/employees/1"
    end
  
    it "should map { :controller => 'employees', :action => 'destroy', :id => 1} to /employees/1" do
      route_for(:controller => "employees", :action => "destroy", :id => 1).should == "/employees/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'employees', action => 'index' } from GET /employees" do
      params_from(:get, "/employees").should == {:controller => "employees", :action => "index"}
    end
  
    it "should generate params { :controller => 'employees', action => 'new' } from GET /employees/new" do
      params_from(:get, "/employees/new").should == {:controller => "employees", :action => "new"}
    end
  
    it "should generate params { :controller => 'employees', action => 'create' } from POST /employees" do
      params_from(:post, "/employees").should == {:controller => "employees", :action => "create"}
    end
  
    it "should generate params { :controller => 'employees', action => 'show', id => '1' } from GET /employees/1" do
      params_from(:get, "/employees/1").should == {:controller => "employees", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'employees', action => 'edit', id => '1' } from GET /employees/1;edit" do
      params_from(:get, "/employees/1/edit").should == {:controller => "employees", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'employees', action => 'update', id => '1' } from PUT /employees/1" do
      params_from(:put, "/employees/1").should == {:controller => "employees", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'employees', action => 'destroy', id => '1' } from DELETE /employees/1" do
      params_from(:delete, "/employees/1").should == {:controller => "employees", :action => "destroy", :id => "1"}
    end
  end
end