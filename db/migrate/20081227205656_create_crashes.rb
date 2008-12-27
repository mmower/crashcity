class CreateCrashes < ActiveRecord::Migration
  def self.up
    create_table :crashes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :crashes
  end
end
