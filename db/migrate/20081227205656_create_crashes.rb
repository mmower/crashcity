class CreateCrashes < ActiveRecord::Migration
  def self.up
    create_table :crashes do |t|
      t.integer :application_id
      t.string :uuid, :limit => 32
      t.string :version, :limit => 16
      t.string :code, :limit => 8
      t.string :path
      t.timestamps
    end
  end

  def self.down
    drop_table :crashes
  end
end
