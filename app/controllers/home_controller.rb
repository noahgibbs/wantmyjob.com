class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :portal

  def index
    @big_logo = true
    @jobs = Job.limit(5)
  end

  # Where to next on the site...
  def portal
    unless current_user.profile
      # Make a new empty profile for the user
      current_user.create_profile
      current_user.save!
      current_user.profile.save!
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
