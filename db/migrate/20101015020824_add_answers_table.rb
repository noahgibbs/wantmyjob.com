class AddAnswersTable < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :job_id, :null => false
      t.integer :answer_type, :null => false
      t.integer :question_id, :null => false
      t.integer :data1, :null => false, :default => 0
      t.integer :data2, :null => false, :default => 0
      t.integer :data3, :null => false, :default => 0
      t.integer :data4, :null => false, :default => 0
      t.integer :data5, :null => false, :default => 0
    end
  end

  def self.down
    drop_table :answers
  end
end
