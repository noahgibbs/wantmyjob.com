class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :portal

  respond_to :html

  def index
    @big_logo = true
    @jobs = Job.limit(5)
  end

  def portal
    redirect_to_next_step
  end
end
