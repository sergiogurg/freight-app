class RemoveRouteUpdateFromOrder < ActiveRecord::Migration[7.0]
  def change
    remove_reference :orders, :route_update, null: true, foreign_key: true
  end
end
