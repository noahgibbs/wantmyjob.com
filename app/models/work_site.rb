class WorkSite < ActiveRecord::Base
  belongs_to :company
  has_many :jobs

  def checked_company_name
    company_id ? company.company_name : company_name
  end
end
