class Job < ActiveRecord::Base
  belongs_to :work_site
  belongs_to :profile

  before_save :check_employer

  def employer
    @employer ||= work_site.company_name
    @employer = work_site.company.name if !@employer && work_site.company
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
