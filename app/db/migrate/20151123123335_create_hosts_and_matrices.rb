class CreateHostsAndMatrices < ActiveRecord::Migration
  def change
    create_table :hosts_and_matrices do |t|
      t.references :host, index: true, foreign_key: true
      t.datetime :collection_time, null: false
      t.string :type, null: false
      t.float :usage, null: false
      t.timestamps null: false
    end
  end
end
