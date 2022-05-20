class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :id_plate
      t.string :make
      t.string :model
      t.string :year
      t.integer :load_capacity
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
