class AddUrlToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :url, :string, :limit => 200
  end

  def self.down
    remove_column :companies, :url
  end
end
