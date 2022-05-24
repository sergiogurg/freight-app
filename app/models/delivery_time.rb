class DeliveryTime < ApplicationRecord
  belongs_to :shipping_company

  validates :initial_distance, :final_distance, :weekdays, presence: true
  validates :initial_distance, :final_distance, :weekdays, uniqueness: true
  validates :initial_distance, :final_distance, :weekdays, numericality: { greater_than_or_equal_to: 0 }
end
