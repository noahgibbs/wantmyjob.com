class AddProfileIdBackToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :profile_id, :integer, :default => 0, :null => false
    remove_column :answers, :data5
  end

  def self.down
    remove_column :answers, :profile_id
    add_column :answers, :data5, :integer, :default => 0, :null => false
  end
end
