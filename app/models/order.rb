class Order < ApplicationRecord
  belongs_to :shipping_company, optional: true
  belongs_to :vehicle, optional: true
  belongs_to :route_update, optional: true

  enum status: { pending: 0, rejected: 5, approved: 10, delivered: 15 }

  before_validation :generate_id_code

  private

  def generate_id_code
    self.id_code = SecureRandom.alphanumeric(15).upcase
  end
end
