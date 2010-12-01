class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :portal

  respond_to :html

  def index
    @big_logo = true
    @jobs = Job.limit(5)
  end

  # Where to next on the site...
  def portal
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

  def suggest
    redirect_to :controller => :profiles, :action => :show_matches
  end
end
