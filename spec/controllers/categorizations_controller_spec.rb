require File.dirname(__FILE__) + '/../spec_helper'

describe CategorizationsController do
  describe "handling GET /categorizations" do

    before(:each) do
      @categorization = mock_model(Categorization)
      Categorization.stub!(:find).and_return([@categorization])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all categorizations" do
      Categorization.should_receive(:find).with(:all).and_return([@categorization])
      do_get
    end
  
    it "should assign the found categorizations for the view" do
      do_get
      assigns[:categorizations].should == [@categorization]
    end
  end

  describe "handling GET /categorizations.xml" do

    before(:each) do
      @categorization = mock_model(Categorization, :to_xml => "XML")
      Categorization.stub!(:find).and_return(@categorization)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all categorizations" do
      Categorization.should_receive(:find).with(:all).and_return([@categorization])
      do_get
    end
  
    it "should render the found categorizations as xml" do
      @categorization.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /categorizations/1" do

    before(:each) do
      @categorization = mock_model(Categorization)
      Categorization.stub!(:find).and_return(@categorization)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the categorization requested" do
      Categorization.should_receive(:find).with("1").and_return(@categorization)
      do_get
    end
  
    it "should assign the found categorization for the view" do
      do_get
      assigns[:categorization].should equal(@categorization)
    end
  end

  describe "handling GET /categorizations/1.xml" do

    before(:each) do
      @categorization = mock_model(Categorization, :to_xml => "XML")
      Categorization.stub!(:find).and_return(@categorization)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the categorization requested" do
      Categorization.should_receive(:find).with("1").and_return(@categorization)
      do_get
    end
  
    it "should render the found categorization as xml" do
      @categorization.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /categorizations/new" do

    before(:each) do
      @categorization = mock_model(Categorization)
      Categorization.stub!(:new).and_return(@categorization)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new categorization" do
      Categorization.should_receive(:new).and_return(@categorization)
      do_get
    end
  
    it "should not save the new categorization" do
      @categorization.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new categorization for the view" do
      do_get
      assigns[:categorization].should equal(@categorization)
    end
  end

  describe "handling GET /categorizations/1/edit" do

    before(:each) do
      @categorization = mock_model(Categorization)
      Categorization.stub!(:find).and_return(@categorization)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the categorization requested" do
      Categorization.should_receive(:find).and_return(@categorization)
      do_get
    end
  
    it "should assign the found Categorization for the view" do
      do_get
      assigns[:categorization].should equal(@categorization)
    end
  end

  describe "handling POST /categorizations" do

    before(:each) do
      @categorization = mock_model(Categorization, :to_param => "1")
      Categorization.stub!(:new).and_return(@categorization)
    end
    
    describe "with successful save" do
  
      def do_post
        @categorization.should_receive(:save).and_return(true)
        post :create, :categorization => {}
      end
  
      it "should create a new categorization" do
        Categorization.should_receive(:new).with({}).and_return(@categorization)
        do_post
      end

      it "should redirect to the new categorization" do
        do_post
        response.should redirect_to(categorization_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @categorization.should_receive(:save).and_return(false)
        post :create, :categorization => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /categorizations/1" do

    before(:each) do
      @categorization = mock_model(Categorization, :to_param => "1")
      Categorization.stub!(:find).and_return(@categorization)
    end
    
    describe "with successful update" do

      def do_put
        @categorization.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the categorization requested" do
        Categorization.should_receive(:find).with("1").and_return(@categorization)
        do_put
      end

      it "should update the found categorization" do
        do_put
        assigns(:categorization).should equal(@categorization)
      end

      it "should assign the found categorization for the view" do
        do_put
        assigns(:categorization).should equal(@categorization)
      end

      it "should redirect to the categorization" do
        do_put
        response.should redirect_to(categorization_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @categorization.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /categorizations/1" do

    before(:each) do
      @categorization = mock_model(Categorization, :destroy => true)
      Categorization.stub!(:find).and_return(@categorization)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the categorization requested" do
      Categorization.should_receive(:find).with("1").and_return(@categorization)
      do_delete
    end
  
    it "should call destroy on the found categorization" do
      @categorization.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the categorizations list" do
      do_delete
      response.should redirect_to(categorizations_url)
    end
  end
end