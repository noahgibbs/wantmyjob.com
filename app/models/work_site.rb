class WorkSite < ActiveRecord::Base
  belongs_to :company
  has_many :jobs

  before_save :generate_search_code

  def checked_company_name
    company_id ? company.company_name : company_name
  end

  def generate_search_code
    return if search_code && !company_name_changed?
    self.search_code = Company.generate_search_code(company_name)
  end
end
