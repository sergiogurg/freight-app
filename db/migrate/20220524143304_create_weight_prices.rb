class CreateWeightPrices < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_prices do |t|
      t.decimal :initial_weight
      t.decimal :final_weight
      t.decimal :price
      t.references :shipping_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
