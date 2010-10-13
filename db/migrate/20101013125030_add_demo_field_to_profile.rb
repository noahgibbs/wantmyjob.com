class AddDemoFieldToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :demo, :boolean
  end

  def self.down
    remove_column :profiles, :demo
  end
end
