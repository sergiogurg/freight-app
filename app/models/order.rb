class Order < ApplicationRecord
  belongs_to :shipping_company, optional: true
  belongs_to :vehicle, optional: true
  belongs_to :route_update, optional: true

  enum status: { pending: 0, rejected: 5, approved: 10, delivered: 15 }

  before_validation :generate_id_code

  validates :origin_address, :product_length, :product_height, :product_width, :product_weight, :destination_address, :status, presence: true
  validates :product_length, :product_height, :product_width, :product_weight, numericality: { greater_than_or_equal_to: 0 }

  private

  def generate_id_code
    if self.id_code.nil?
      self.id_code = SecureRandom.alphanumeric(15).upcase
    end
  end
end
