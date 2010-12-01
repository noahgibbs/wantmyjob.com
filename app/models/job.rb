class Job < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :profile
  has_many :answers
  has_many :utterly_naive_matches
  has_one :company, :through => :work_site

  attr_accessible :title, :start_date, :end_date, :profile_id

  before_save :check_employer

  include ActionView::Helpers::UrlHelper

  def employer_link
    co = work_site.company
    if co
      return ("#{link_to(co.company_name, '/companies/' + co.id.to_s)} " +
        "(#{link_to('location', '/work_sites/' + work_site.id.to_s)})").html_safe
    end

    link_to(work_site.company_name + " (unmerged)", "/work_sites/#{work_site.id}")
  end

  def employer
    @employer ||= work_site.company_name
    @employer ||= work_site.company.company_name if work_site.company
    @employer
  end

  def employer=(new_emp)
    @employer = new_emp
  end

  protected

  # If an "employer" field is set, and the work site isn't
  # already known, 
  def check_employer
    return unless self.employer
    if self.work_site_id
      self.employer = nil
      return
    end

    site = WorkSite.new(:company_name => self.employer)
    if(site.save)
      self.work_site_id = site.id
    else
      raise "No work site set, and couldn't create one!"
    end
  end

end
