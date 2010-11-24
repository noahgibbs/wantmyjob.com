class Company < ActiveRecord::Base
  has_many :work_sites

  IGNORED_WORDS = {
    "inc" => true,
    "co" => true,
    "company" => true,
    "corp" => true,
    "corporation" => true,
    "incorporated" => true,
    "llc" => true,
    "limited" => true,
    "group" => true,
    "com" => true,
    "technology" => true,
    "systems" => true,
    "center" => true,
  }

  def generate_search_code
    return if search_code && !company_name_changed?
    self.search_code = Company.generate_search_code(company_name)
  end

  def self.generate_search_code(company_name)
    words = company_name.split(/(\w+)/).select {|w| w =~ /\w+/}.map(&:downcase)
    words = words.select {|w| !IGNORED_WORDS.include?(w)}

    words.join(" ")
  end
end
