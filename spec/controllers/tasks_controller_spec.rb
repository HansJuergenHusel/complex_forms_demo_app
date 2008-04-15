require File.dirname(__FILE__) + '/../spec_helper'

describe TasksController do
  describe "handling GET /tasks" do

    before(:each) do
      @task = mock_model(Task)
      Task.stub!(:find).and_return([@task])
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
  
    it "should find all tasks" do
      Task.should_receive(:find).with(:all).and_return([@task])
      do_get
    end
  
    it "should assign the found tasks for the view" do
      do_get
      assigns[:tasks].should == [@task]
    end
  end

  describe "handling GET /tasks.xml" do

    before(:each) do
      @task = mock_model(Task, :to_xml => "XML")
      Task.stub!(:find).and_return(@task)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all tasks" do
      Task.should_receive(:find).with(:all).and_return([@task])
      do_get
    end
  
    it "should render the found tasks as xml" do
      @task.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /tasks/1" do

    before(:each) do
      @task = mock_model(Task)
      Task.stub!(:find).and_return(@task)
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
  
    it "should find the task requested" do
      Task.should_receive(:find).with("1").and_return(@task)
      do_get
    end
  
    it "should assign the found task for the view" do
      do_get
      assigns[:task].should equal(@task)
    end
  end

  describe "handling GET /tasks/1.xml" do

    before(:each) do
      @task = mock_model(Task, :to_xml => "XML")
      Task.stub!(:find).and_return(@task)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the task requested" do
      Task.should_receive(:find).with("1").and_return(@task)
      do_get
    end
  
    it "should render the found task as xml" do
      @task.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /tasks/new" do

    before(:each) do
      @task = mock_model(Task)
      Task.stub!(:new).and_return(@task)
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
  
    it "should create an new task" do
      Task.should_receive(:new).and_return(@task)
      do_get
    end
  
    it "should not save the new task" do
      @task.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new task for the view" do
      do_get
      assigns[:task].should equal(@task)
    end
  end

  describe "handling GET /tasks/1/edit" do

    before(:each) do
      @task = mock_model(Task)
      Task.stub!(:find).and_return(@task)
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
  
    it "should find the task requested" do
      Task.should_receive(:find).and_return(@task)
      do_get
    end
  
    it "should assign the found Task for the view" do
      do_get
      assigns[:task].should equal(@task)
    end
  end

  describe "handling POST /tasks" do

    before(:each) do
      @task = mock_model(Task, :to_param => "1")
      Task.stub!(:new).and_return(@task)
    end
    
    describe "with successful save" do
  
      def do_post
        @task.should_receive(:save).and_return(true)
        post :create, :task => {}
      end
  
      it "should create a new task" do
        Task.should_receive(:new).with({}).and_return(@task)
        do_post
      end

      it "should redirect to the new task" do
        do_post
        response.should redirect_to(task_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @task.should_receive(:save).and_return(false)
        post :create, :task => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /tasks/1" do

    before(:each) do
      @task = mock_model(Task, :to_param => "1")
      Task.stub!(:find).and_return(@task)
    end
    
    describe "with successful update" do

      def do_put
        @task.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the task requested" do
        Task.should_receive(:find).with("1").and_return(@task)
        do_put
      end

      it "should update the found task" do
        do_put
        assigns(:task).should equal(@task)
      end

      it "should assign the found task for the view" do
        do_put
        assigns(:task).should equal(@task)
      end

      it "should redirect to the task" do
        do_put
        response.should redirect_to(task_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @task.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /tasks/1" do

    before(:each) do
      @task = mock_model(Task, :destroy => true)
      Task.stub!(:find).and_return(@task)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the task requested" do
      Task.should_receive(:find).with("1").and_return(@task)
      do_delete
    end
  
    it "should call destroy on the found task" do
      @task.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the tasks list" do
      do_delete
      response.should redirect_to(tasks_url)
    end
  end
end