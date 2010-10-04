class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :company_name, :limit => 200
      t.integer :headquarters   # This is a work_site ID
      t.string :apply_email, :limit => 100

      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
