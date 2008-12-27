class CreateApplications < ActiveRecord::Migration
  def self.up
    create_table :applications do |t|
      t.string :process, :limit => 32
      t.string :bundle, :limit => 32
      t.timestamps
    end
  end

  def self.down
    drop_table :applications
  end
end
