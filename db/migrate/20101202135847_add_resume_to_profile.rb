class AddResumeToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :resume, :text, :limit => 128 * 1024
  end

  def self.down
    drop_column :profiles, :resume
  end
end
