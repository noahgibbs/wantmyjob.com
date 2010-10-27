class CreateUtterlyNaiveMatches < ActiveRecord::Migration
  def self.up
    create_table :utterly_naive_matches do |t|
      t.integer :matching
      t.integer :match_out_of
      t.integer :question_overlap

      t.timestamps
    end
  end

  def self.down
    drop_table :utterly_naive_matches
  end
end
