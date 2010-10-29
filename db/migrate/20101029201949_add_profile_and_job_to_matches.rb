class AddProfileAndJobToMatches < ActiveRecord::Migration
  def self.up
    add_column :utterly_naive_matches, :profile_id, :integer, :null => false
    add_column :utterly_naive_matches, :job_id, :integer, :null => false
  end

  def self.down
    remove_column :utterly_naive_matches, :profile_id
    remove_column :utterly_naive_matches, :job_id
  end
end
