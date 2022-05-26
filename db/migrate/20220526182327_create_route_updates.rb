class CreateRouteUpdates < ActiveRecord::Migration[7.0]
  def change
    create_table :route_updates do |t|
      t.string :date
      t.string :time
      t.string :current_location

      t.timestamps
    end
  end
end
