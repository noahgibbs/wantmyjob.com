class AddSoftDeleteColumns < ActiveRecord::Migration
  TABLES = [:questions, :profiles, :companies, :jobs, :work_sites]

  def self.up
    TABLES.each do |table_name|
      add_column table_name, :soft_deleted,
                 :boolean, :default => false
    end
  end

  def self.down
    TABLES.each do |table_name|
      remove_column table_name, :soft_deleted
    end
  end
end
