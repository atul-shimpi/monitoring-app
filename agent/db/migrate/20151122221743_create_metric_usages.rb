class CreateMetricUsages < ActiveRecord::Migration
  def change
    create_table :metric_usages do |t|
      t.string :type, null: false
      t.float :usage, null: false
      t.timestamps null: false
    end
  end
end
