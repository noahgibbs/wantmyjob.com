class JobsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin, :except => [:edit, :enter, :enter_post]

  respond_to :html

  # Action for entering a list of new jobs
  def enter
    @jobs = Job.new
  end

  def enter_post
    params[:jobs].each do |job_hash|
      next if (job_hash[:employer].nil? || job_hash[:employer].empty?) &&
        (job_hash[:title].nil? || job_hash[:title].empty?)

      job = Job.new job_hash
      job.profile = current_user.profile
      if job_hash[:employer] && !job_hash[:employer].empty?
        job.work_site = WorkSite.new(:company_name => job_hash[:employer])
        job.work_site.save!
      end
      job.save!
    end

    redirect_to :controller => :questions, :action => :answer
  end

  # GET /jobs
  # GET /jobs.xml
  def index
    @jobs = Job.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @jobs }
    end
  end

  # GET /jobs/1
  # GET /jobs/1.xml
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/new
  # GET /jobs/new.xml
  def new
    @job = Job.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @job }
    end
  end

  # GET /jobs/1/edit
  def edit
    if current_user.admin
      @job = Job.find(params[:id])
    else
      @job = Job.where(:profile_id => current_user.profile.id).find(params[:id])
    end
  end

  # POST /jobs
  # POST /jobs.xml
  def create
    @job = Job.new(params[:job])

    respond_to do |format|
      if @job.save
        format.html { redirect_to(@job, :notice => 'Job was successfully created.') }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /jobs/1
  # PUT /jobs/1.xml
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to(@job, :notice => 'Job was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.xml
  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
  end
end
