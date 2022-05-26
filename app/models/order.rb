class Order < ApplicationRecord
  belongs_to :shipping_company
  belongs_to :vehicle
  belongs_to :route_update

  enum status: { pending: 0, rejected: 5, approved: 10, delivered: 15 }
end
