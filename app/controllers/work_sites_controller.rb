class WorkSitesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :requires_admin, :only => SCAFFOLD_ACTIONS

  # GET /work_sites
  # GET /work_sites.xml
  def index
    @work_sites = WorkSite.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @work_sites }
    end
  end

  # GET /work_sites/1
  # GET /work_sites/1.xml
  def show
    @work_site = WorkSite.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @work_site }
    end
  end

  # GET /work_sites/new
  # GET /work_sites/new.xml
  def new
    @work_site = WorkSite.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @work_site }
    end
  end

  # GET /work_sites/1/edit
  def edit
    @work_site = WorkSite.find(params[:id])
  end

  # POST /work_sites
  # POST /work_sites.xml
  def create
    @work_site = WorkSite.new(params[:work_site])

    respond_to do |format|
      if @work_site.save
        format.html { redirect_to(@work_site, :notice => 'Work site was successfully created.') }
        format.xml  { render :xml => @work_site, :status => :created, :location => @work_site }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @work_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /work_sites/1
  # PUT /work_sites/1.xml
  def update
    @work_site = WorkSite.find(params[:id])

    respond_to do |format|
      if @work_site.update_attributes(params[:work_site])
        format.html { redirect_to(@work_site, :notice => 'Work site was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @work_site.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /work_sites/1
  # DELETE /work_sites/1.xml
  def destroy
    @work_site = WorkSite.find(params[:id])
    @work_site.destroy

    respond_to do |format|
      format.html { redirect_to(work_sites_url) }
      format.xml  { head :ok }
    end
  end
end
