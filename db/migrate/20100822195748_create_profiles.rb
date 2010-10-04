class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :fullname
      t.integer :birth_day
      t.integer :birth_month
      t.integer :birth_year
      t.integer :gender
      t.string :time_zone
      t.text :address
      t.string :country
      t.string :state
      t.integer :user_id

      t.boolean :verified

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
