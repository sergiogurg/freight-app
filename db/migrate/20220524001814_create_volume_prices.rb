class CreateVolumePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :volume_prices do |t|
      t.decimal :initial_volume
      t.decimal :final_volume
      t.decimal :price
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
