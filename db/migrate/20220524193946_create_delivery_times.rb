class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.decimal :initial_distance
      t.decimal :final_distance
      t.integer :weekdays
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
