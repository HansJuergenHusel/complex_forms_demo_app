require File.dirname(__FILE__) + '/../spec_helper'

describe CategorizationsController do
  describe "route generation" do

    it "should map { :controller => 'categorizations', :action => 'index' } to /categorizations" do
      route_for(:controller => "categorizations", :action => "index").should == "/categorizations"
    end
  
    it "should map { :controller => 'categorizations', :action => 'new' } to /categorizations/new" do
      route_for(:controller => "categorizations", :action => "new").should == "/categorizations/new"
    end
  
    it "should map { :controller => 'categorizations', :action => 'show', :id => 1 } to /categorizations/1" do
      route_for(:controller => "categorizations", :action => "show", :id => 1).should == "/categorizations/1"
    end
  
    it "should map { :controller => 'categorizations', :action => 'edit', :id => 1 } to /categorizations/1/edit" do
      route_for(:controller => "categorizations", :action => "edit", :id => 1).should == "/categorizations/1/edit"
    end
  
    it "should map { :controller => 'categorizations', :action => 'update', :id => 1} to /categorizations/1" do
      route_for(:controller => "categorizations", :action => "update", :id => 1).should == "/categorizations/1"
    end
  
    it "should map { :controller => 'categorizations', :action => 'destroy', :id => 1} to /categorizations/1" do
      route_for(:controller => "categorizations", :action => "destroy", :id => 1).should == "/categorizations/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'categorizations', action => 'index' } from GET /categorizations" do
      params_from(:get, "/categorizations").should == {:controller => "categorizations", :action => "index"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'new' } from GET /categorizations/new" do
      params_from(:get, "/categorizations/new").should == {:controller => "categorizations", :action => "new"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'create' } from POST /categorizations" do
      params_from(:post, "/categorizations").should == {:controller => "categorizations", :action => "create"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'show', id => '1' } from GET /categorizations/1" do
      params_from(:get, "/categorizations/1").should == {:controller => "categorizations", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'edit', id => '1' } from GET /categorizations/1;edit" do
      params_from(:get, "/categorizations/1/edit").should == {:controller => "categorizations", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'update', id => '1' } from PUT /categorizations/1" do
      params_from(:put, "/categorizations/1").should == {:controller => "categorizations", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'categorizations', action => 'destroy', id => '1' } from DELETE /categorizations/1" do
      params_from(:delete, "/categorizations/1").should == {:controller => "categorizations", :action => "destroy", :id => "1"}
    end
  end
end