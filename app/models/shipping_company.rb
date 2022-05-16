class ShippingCompany < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email_domain, :address, presence: true
end
