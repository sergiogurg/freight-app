class AddAddressToShippingCompany < ActiveRecord::Migration[7.0]
  def change
    add_column :shipping_companies, :address, :string
  end
end
