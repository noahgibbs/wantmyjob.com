class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name, :limit => 200
      t.text :address
      t.apply_email :string, :limit => 100

      t.timestamps
    end
  end

  def self.down
  end
end
