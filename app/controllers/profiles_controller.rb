class ProfilesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin, :only => SCAFFOLD_ACTIONS

  respond_to :html

  expose(:profile)
  expose(:jobs) { profile.jobs }

  def me
    params[:id] = current_user.profile.id
  end

  def clear_matches
    UtterlyNaiveMatch.where(current_user.profile.id).delete_all
    redirect_to :controller => :profiles, :action => :show_matches
  end

  def show_matches
    pid = current_user.profile.id
    all_matches = UtterlyNaiveMatch.where(:profile_id => pid)
    my_jobs = current_user.profile.jobs.map(&:id)

    @perfect_answers = Answer.where(:profile_id => pid,
                                :answer_type => Answer::PERFECT_COMPANY_ANSWER)

    # Order the matches appropriately (by match_confidence, descending)
    @matches = all_matches.sort_by {|match| -match.match_confidence}
    @matches = @matches.select {|match| match.match_confidence >= 0.05 &&
                                 match.question_overlap >= 2}
    @matches = @matches.select {|match| !my_jobs.include?(match.job_id)} unless params[:self_match]

    if all_matches && !all_matches.empty?
      @last_match_time = all_matches[0].updated_at
    end
  end

  def recalculate_matches
    pid = current_user.profile.id
    one_match = UtterlyNaiveMatch.where(:profile_id => pid).limit(1)
    last_match_time = one_match.first.updated_at

    if (Time.now - last_match_time > 10.minutes)
      flash[:notice] = "We just recalculated your matches."
      UtterlyNaiveMatch.create_matches_for current_user.profile
    else
      flash[:warning] = "You can only recalculate every ten minutes."
    end

    redirect_to :controller => :profiles, :action => :show_matches
  end

  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    @profile = Profile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to(@profile, :notice => 'Profile was successfully created.') }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to(@profile, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
