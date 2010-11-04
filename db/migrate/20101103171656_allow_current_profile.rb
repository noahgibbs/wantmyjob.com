class AllowCurrentProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :current, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :profiles, :current
  end
end
