class VolumePrice < ApplicationRecord
  belongs_to :shipping_company

  validates :initial_volume, :final_volume, :price, presence: true
  validates :initial_volume, :final_volume, :price, uniqueness: true
end
