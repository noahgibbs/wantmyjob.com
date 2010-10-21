require 'spec_helper'
require 'devise/test_helpers'

describe JobsController do
  include Devise::TestHelpers

  before(:each) do
    # mock up an authentication in the underlying warden library
    request.env['warden'] = mock(Warden, :authenticate => mock_user,
                                 :authenticate! => mock_user)
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_job(stubs={})
    (@mock_job ||= mock_model(Job).as_null_object).tap do |job|
      job.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET enter" do
    it "doesn't fail completely" do
      get :enter
    end
  end

  describe "POST enter_post" do
    it "should create three jobs with the correct parameters" do
      PARAMS1 = { "employer" => "BogoMIPS", "title" => "Yahoo"}
      PARAMS2 = { "employer" => "Consolidated Accumulated" }
      PARAMS3 = { "title" => "Senior Vice-Chancellor"}

      job = mock_model(Job)
      profile = mock_model(Profile)

      mock_user.stub(:profile) { profile }
      create_times = 0
      Job.should_receive(:new).exactly(3).times.and_return(job) { |args|
        case create_times
          when 0: args.should == PARAMS1.merge("profile_id" => profile.id)
          when 1: args.should == PARAMS2.merge("profile_id" => profile.id)
          when 2: args.should == PARAMS3.merge("profile_id" => profile.id)
          else raise "Job.new should only be called three times!"
        end

        create_times += 1
        job
      }
      job.should_receive(:save!).exactly(3).times

      post :enter_post,
           :jobs => [{ "employer" => "BogoMIPS", "title" => "Yahoo"},
                     { "employer" => "", "title" => ""},
                     { "employer" => "Consolidated Accumulated" },
                     { "title" => "Senior Vice-Chancellor"},
                     { }
                    ]
    end

    it "should redirect to the answer-questions page" do
      post :enter_post, :jobs => [{}]
      should redirect_to(:controller => :questions, :action => :answer)
    end
  end

  describe "GET index" do
    it "assigns all jobs as @jobs" do
      Job.stub(:all) { [mock_job] }
      get :index
      assigns(:jobs).should eq([mock_job])
    end
  end

  describe "GET show" do
    it "assigns the requested job as @job" do
      Job.stub(:find).with("37") { mock_job }
      get :show, :id => "37"
      assigns(:job).should be(mock_job)
    end
  end

  describe "GET new" do
    it "assigns a new job as @job" do
      Job.stub(:new) { mock_job }
      get :new
      assigns(:job).should be(mock_job)
    end
  end

  describe "GET edit" do
    it "assigns the requested job as @job" do
      Job.stub(:find).with("37") { mock_job }
      get :edit, :id => "37"
      assigns(:job).should be(mock_job)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created job as @job" do
        Job.stub(:new).with({'these' => 'params'}) { mock_job(:save => true) }
        post :create, :job => {'these' => 'params'}
        assigns(:job).should be(mock_job)
      end

      it "redirects to the created job" do
        Job.stub(:new) { mock_job(:save => true) }
        post :create, :job => {}
        response.should redirect_to(job_url(mock_job))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved job as @job" do
        Job.stub(:new).with({'these' => 'params'}) { mock_job(:save => false) }
        post :create, :job => {'these' => 'params'}
        assigns(:job).should be(mock_job)
      end

      it "re-renders the 'new' template" do
        Job.stub(:new) { mock_job(:save => false) }
        post :create, :job => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested job" do
        Job.should_receive(:find).with("37") { mock_job }
        mock_job.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :job => {'these' => 'params'}
      end

      it "assigns the requested job as @job" do
        Job.stub(:find) { mock_job(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:job).should be(mock_job)
      end

      it "redirects to the job" do
        Job.stub(:find) { mock_job(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(job_url(mock_job))
      end
    end

    describe "with invalid params" do
      it "assigns the job as @job" do
        Job.stub(:find) { mock_job(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:job).should be(mock_job)
      end

      it "re-renders the 'edit' template" do
        Job.stub(:find) { mock_job(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested job" do
      Job.should_receive(:find).with("37") { mock_job }
      mock_job.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the jobs list" do
      Job.stub(:find) { mock_job }
      delete :destroy, :id => "1"
      response.should redirect_to(jobs_url)
    end
  end

end
