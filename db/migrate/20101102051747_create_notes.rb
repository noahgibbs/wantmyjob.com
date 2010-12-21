class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.integer :note_type
      t.text :body
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
