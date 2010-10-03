class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :question_type
      t.text :text, :limit => 3000
      t.integer :created_by
      t.boolean :approved
      t.boolean :completed

      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
