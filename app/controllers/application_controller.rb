class ApplicationController < ActionController::Base
  protect_from_forgery

  SCAFFOLD_ACTIONS = [:index, :show, :new, :create, :edit, :update, :destroy]

  def requires_admin
    redirect_to "/" unless current_user.admin || script_run_as_admin
  end

  def script_run_as_admin(new_val = nil)
    @script_run_as_admin = new_val unless new_val.nil?
    @script_run_as_admin
  end

  def malformed_url_error
    render :text => "Bad URL!  Did you paste it wrong, maybe?", :status => 404
  end

  def redirect_to_next_step
    unless current_user
      redirect_to :controller => :home, :action => :index
      return
    end

    unless current_user.profile
      # Make a new empty profile for the user
      p = Profile.new
      current_user.profiles << p
      current_user.save!
      p.save!
    end

    # Check to see if the user has entered any current jobs
    jobs = Job.where :profile_id => current_user.profile.id
    if(jobs == nil || jobs.empty?)
      redirect_to :controller => :jobs, :action => :enter
      return
    end

    # Assume there are still questions to answer
    redirect_to :controller => :questions, :action => :answer
  end
end
