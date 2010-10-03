class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :title, :limit => 100
      t.date :start_date
      t.date :end_date
      t.integer :company_id
      t.integer :profile_id
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
