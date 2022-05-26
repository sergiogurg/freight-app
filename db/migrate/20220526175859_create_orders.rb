class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :origin_address
      t.string :id_code
      t.decimal :product_length
      t.decimal :product_height
      t.decimal :product_width
      t.decimal :product_weight
      t.string :destination_address
      t.integer :status, default: 0
      t.references :shipping_company, null: true, foreign_key: true
      t.references :vehicle, null: true, foreign_key: true
      t.references :route_update, null: true, foreign_key: true

      t.timestamps
    end
  end
end
