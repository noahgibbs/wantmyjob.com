class MakeAnswersProfileIdNotDefaultable < ActiveRecord::Migration
  def self.up
    remove_column :answers, :profile_id
    add_column :answers, :profile_id, :integer, :null => false, :default => nil
  end

  def self.down
    remove_column :answers, :profile_id
    add_column :answers, :profile_id, :integer, :null => false, :default => 0
  end
end
