class ShippingCompany < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email_domain, :address, presence: true
  validates :corporate_name, :registration_number, :email_domain, uniqueness: true

  has_many :vehicles
  has_many :volume_prices
  has_many :weight_prices
  has_many :delivery_times
end
