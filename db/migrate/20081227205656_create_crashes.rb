class CreateCrashes < ActiveRecord::Migration
  def self.up
    create_table :crashes do |t|
      t.integer :app_id
      t.string :uuid, :limit => 32
      t.string :path
      t.string :version, :limit => 8
      t.string :revision, :limit => 16
      t.string :code, :limit => 8
      t.string :osver, :limit => 24
      t.string :extype, :limit => 32
      t.string :excode, :limit => 64
      t.timestamps
    end
  end

  def self.down
    drop_table :crashes
  end
end
