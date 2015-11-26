class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :description, limit: 50
      t.string :ip_or_host_name, limit: 50, null: false
      t.integer :port, null: false, default: 3000
      t.integer :connection_status, default: 0
      t.timestamps null: false
    end
  end
end
