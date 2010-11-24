class RemoveSoftDeleteFlags < ActiveRecord::Migration
  def self.up
    remove_column :companies, :soft_deleted
    remove_column :jobs, :soft_deleted
    remove_column :profiles, :soft_deleted
    remove_column :questions, :soft_deleted
    remove_column :work_sites, :soft_deleted
  end

  def self.down
    add_column :companies, :soft_deleted, :boolean, :default => false
    add_column :jobs, :soft_deleted, :boolean, :default => false
    add_column :profiles, :soft_deleted, :boolean, :default => false
    add_column :questions, :soft_deleted, :boolean, :default => false
    add_column :work_sites, :soft_deleted, :boolean, :default => false
  end
end
