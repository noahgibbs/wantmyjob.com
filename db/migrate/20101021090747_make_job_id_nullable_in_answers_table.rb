class MakeJobIdNullableInAnswersTable < ActiveRecord::Migration
  def self.up
    change_column :answers, :job_id, :integer, :null => true
  end

  def self.down
    change_column :answers, :job_id, :integer, :null => false
  end
end
