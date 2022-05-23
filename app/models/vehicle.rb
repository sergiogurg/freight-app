class Vehicle < ApplicationRecord
  belongs_to :shipping_company

  validates :id_plate, :make, :model, :year, :load_capacity, presence: true
  validates :id_plate, uniqueness: true
end
