require File.dirname(__FILE__) + '/../spec_helper'

describe AssignmentsController do
  describe "handling GET /assignments" do

    before(:each) do
      @assignment = mock_model(Assignment)
      Assignment.stub!(:find).and_return([@assignment])
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
  
    it "should find all assignments" do
      Assignment.should_receive(:find).with(:all).and_return([@assignment])
      do_get
    end
  
    it "should assign the found assignments for the view" do
      do_get
      assigns[:assignments].should == [@assignment]
    end
  end

  describe "handling GET /assignments.xml" do

    before(:each) do
      @assignment = mock_model(Assignment, :to_xml => "XML")
      Assignment.stub!(:find).and_return(@assignment)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all assignments" do
      Assignment.should_receive(:find).with(:all).and_return([@assignment])
      do_get
    end
  
    it "should render the found assignments as xml" do
      @assignment.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /assignments/1" do

    before(:each) do
      @assignment = mock_model(Assignment)
      Assignment.stub!(:find).and_return(@assignment)
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
  
    it "should find the assignment requested" do
      Assignment.should_receive(:find).with("1").and_return(@assignment)
      do_get
    end
  
    it "should assign the found assignment for the view" do
      do_get
      assigns[:assignment].should equal(@assignment)
    end
  end

  describe "handling GET /assignments/1.xml" do

    before(:each) do
      @assignment = mock_model(Assignment, :to_xml => "XML")
      Assignment.stub!(:find).and_return(@assignment)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the assignment requested" do
      Assignment.should_receive(:find).with("1").and_return(@assignment)
      do_get
    end
  
    it "should render the found assignment as xml" do
      @assignment.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /assignments/new" do

    before(:each) do
      @assignment = mock_model(Assignment)
      Assignment.stub!(:new).and_return(@assignment)
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
  
    it "should create an new assignment" do
      Assignment.should_receive(:new).and_return(@assignment)
      do_get
    end
  
    it "should not save the new assignment" do
      @assignment.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new assignment for the view" do
      do_get
      assigns[:assignment].should equal(@assignment)
    end
  end

  describe "handling GET /assignments/1/edit" do

    before(:each) do
      @assignment = mock_model(Assignment)
      Assignment.stub!(:find).and_return(@assignment)
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
  
    it "should find the assignment requested" do
      Assignment.should_receive(:find).and_return(@assignment)
      do_get
    end
  
    it "should assign the found Assignment for the view" do
      do_get
      assigns[:assignment].should equal(@assignment)
    end
  end

  describe "handling POST /assignments" do

    before(:each) do
      @assignment = mock_model(Assignment, :to_param => "1")
      Assignment.stub!(:new).and_return(@assignment)
    end
    
    describe "with successful save" do
  
      def do_post
        @assignment.should_receive(:save).and_return(true)
        post :create, :assignment => {}
      end
  
      it "should create a new assignment" do
        Assignment.should_receive(:new).with({}).and_return(@assignment)
        do_post
      end

      it "should redirect to the new assignment" do
        do_post
        response.should redirect_to(assignment_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @assignment.should_receive(:save).and_return(false)
        post :create, :assignment => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /assignments/1" do

    before(:each) do
      @assignment = mock_model(Assignment, :to_param => "1")
      Assignment.stub!(:find).and_return(@assignment)
    end
    
    describe "with successful update" do

      def do_put
        @assignment.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the assignment requested" do
        Assignment.should_receive(:find).with("1").and_return(@assignment)
        do_put
      end

      it "should update the found assignment" do
        do_put
        assigns(:assignment).should equal(@assignment)
      end

      it "should assign the found assignment for the view" do
        do_put
        assigns(:assignment).should equal(@assignment)
      end

      it "should redirect to the assignment" do
        do_put
        response.should redirect_to(assignment_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @assignment.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /assignments/1" do

    before(:each) do
      @assignment = mock_model(Assignment, :destroy => true)
      Assignment.stub!(:find).and_return(@assignment)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the assignment requested" do
      Assignment.should_receive(:find).with("1").and_return(@assignment)
      do_delete
    end
  
    it "should call destroy on the found assignment" do
      @assignment.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the assignments list" do
      do_delete
      response.should redirect_to(assignments_url)
    end
  end
end