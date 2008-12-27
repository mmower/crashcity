class CreateCrashes < ActiveRecord::Migration
  def self.up
    create_table :crashes do |t|
      t.integer :application_id
      t.string :version
      t.string :code
      t.string :path
      t.timestamps
    end
  end

  def self.down
    drop_table :crashes
  end
end
