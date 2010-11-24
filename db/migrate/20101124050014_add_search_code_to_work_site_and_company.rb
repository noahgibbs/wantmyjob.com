class AddSearchCodeToWorkSiteAndCompany < ActiveRecord::Migration
  def self.up
    add_column :work_sites, :search_code, :string, :limit => 200
    add_column :companies, :search_code, :string, :limit => 200

    WorkSite.find_each do |site|
      site.generate_search_code
      site.save!
    end

    Company.find_each do |co|
      co.generate_search_code
      co.save!
    end
  end

  def self.down
    remove_column :work_sites, :search_code
    remove_column :companies, :search_code
  end
end
