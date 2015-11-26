class CreateHostAndMatricesRecordIds < ActiveRecord::Migration
  def change
    create_table :host_and_matrices_record_ids do |t|
      t.references :host, index: true, foreign_key: true
      t.string :type
      t.integer :last_record_id
      t.timestamps null: false
    end
  end
end
