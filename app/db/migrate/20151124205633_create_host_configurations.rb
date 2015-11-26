class CreateHostConfigurations < ActiveRecord::Migration
  def change
    create_table :host_configurations do |t|
      t.references :host
      t.string :os, limit: 25, null: false
      t.string :cpu_size, limit: 10, null: false, default: 0
      t.integer :disk_size, null: false, default: 0
      t.timestamps null: false
    end
  end
end
