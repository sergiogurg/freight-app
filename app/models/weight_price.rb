class WeightPrice < ApplicationRecord
  belongs_to :shipping_company

  validates :initial_weight, :final_weight, :price, presence: true
  validates :initial_weight, :final_weight, :price, uniqueness: true
  validates :initial_weight, :final_weight, :price, numericality: { greater_than_or_equal_to: 0 }
end
