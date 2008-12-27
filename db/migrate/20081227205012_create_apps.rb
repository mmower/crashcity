class CreateApps < ActiveRecord::Migration
  def self.up
    create_table :apps do |t|
      t.string :process, :limit => 32
      t.string :bundle, :limit => 32
      t.timestamps
    end
  end

  def self.down
    drop_table :apps
  end
end
