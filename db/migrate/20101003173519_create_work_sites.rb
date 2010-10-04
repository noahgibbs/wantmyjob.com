class CreateWorkSites < ActiveRecord::Migration
  def self.up
    create_table :work_sites do |t|
      t.string :company_name, :limit => 200
      t.integer :company_id
      t.string :description, :limit => 200
      t.text :address

      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :work_sites
  end
end
