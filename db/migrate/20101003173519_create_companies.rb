class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name, :limit => 200
      t.text :address
      t.string :apply_email, :limit => 100

      t.timestamps
    end
  end

  def self.down
  end
end
