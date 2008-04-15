require File.dirname(__FILE__) + '/../spec_helper'

describe EmployeesController do
  describe "handling GET /employees" do

    before(:each) do
      @employee = mock_model(Employee)
      Employee.stub!(:find).and_return([@employee])
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
  
    it "should find all employees" do
      Employee.should_receive(:find).with(:all).and_return([@employee])
      do_get
    end
  
    it "should assign the found employees for the view" do
      do_get
      assigns[:employees].should == [@employee]
    end
  end

  describe "handling GET /employees.xml" do

    before(:each) do
      @employee = mock_model(Employee, :to_xml => "XML")
      Employee.stub!(:find).and_return(@employee)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all employees" do
      Employee.should_receive(:find).with(:all).and_return([@employee])
      do_get
    end
  
    it "should render the found employees as xml" do
      @employee.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /employees/1" do

    before(:each) do
      @employee = mock_model(Employee)
      Employee.stub!(:find).and_return(@employee)
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
  
    it "should find the employee requested" do
      Employee.should_receive(:find).with("1").and_return(@employee)
      do_get
    end
  
    it "should assign the found employee for the view" do
      do_get
      assigns[:employee].should equal(@employee)
    end
  end

  describe "handling GET /employees/1.xml" do

    before(:each) do
      @employee = mock_model(Employee, :to_xml => "XML")
      Employee.stub!(:find).and_return(@employee)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the employee requested" do
      Employee.should_receive(:find).with("1").and_return(@employee)
      do_get
    end
  
    it "should render the found employee as xml" do
      @employee.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /employees/new" do

    before(:each) do
      @employee = mock_model(Employee)
      Employee.stub!(:new).and_return(@employee)
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
  
    it "should create an new employee" do
      Employee.should_receive(:new).and_return(@employee)
      do_get
    end
  
    it "should not save the new employee" do
      @employee.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new employee for the view" do
      do_get
      assigns[:employee].should equal(@employee)
    end
  end

  describe "handling GET /employees/1/edit" do

    before(:each) do
      @employee = mock_model(Employee)
      Employee.stub!(:find).and_return(@employee)
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
  
    it "should find the employee requested" do
      Employee.should_receive(:find).and_return(@employee)
      do_get
    end
  
    it "should assign the found Employee for the view" do
      do_get
      assigns[:employee].should equal(@employee)
    end
  end

  describe "handling POST /employees" do

    before(:each) do
      @employee = mock_model(Employee, :to_param => "1")
      Employee.stub!(:new).and_return(@employee)
    end
    
    describe "with successful save" do
  
      def do_post
        @employee.should_receive(:save).and_return(true)
        post :create, :employee => {}
      end
  
      it "should create a new employee" do
        Employee.should_receive(:new).with({}).and_return(@employee)
        do_post
      end

      it "should redirect to the new employee" do
        do_post
        response.should redirect_to(employee_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @employee.should_receive(:save).and_return(false)
        post :create, :employee => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /employees/1" do

    before(:each) do
      @employee = mock_model(Employee, :to_param => "1")
      Employee.stub!(:find).and_return(@employee)
    end
    
    describe "with successful update" do

      def do_put
        @employee.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the employee requested" do
        Employee.should_receive(:find).with("1").and_return(@employee)
        do_put
      end

      it "should update the found employee" do
        do_put
        assigns(:employee).should equal(@employee)
      end

      it "should assign the found employee for the view" do
        do_put
        assigns(:employee).should equal(@employee)
      end

      it "should redirect to the employee" do
        do_put
        response.should redirect_to(employee_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @employee.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /employees/1" do

    before(:each) do
      @employee = mock_model(Employee, :destroy => true)
      Employee.stub!(:find).and_return(@employee)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the employee requested" do
      Employee.should_receive(:find).with("1").and_return(@employee)
      do_delete
    end
  
    it "should call destroy on the found employee" do
      @employee.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the employees list" do
      do_delete
      response.should redirect_to(employees_url)
    end
  end
end