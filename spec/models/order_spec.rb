require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Order gera um código automaticamente' do
    it 'antes de ser validado' do
      # Arrange
      order = Order.new(origin_address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE')

      # Act
      order.save!
      result = order.id_code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq(15)
    end

    it 'e ele é aleatório' do
      # Arrange
      first_order = Order.create!(origin_address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE')
      second_order = order = Order.new(origin_address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP', product_length: 50, product_height: 35, product_width: 10, product_weight: 4.76, destination_address: 'Av. Aliomar Baleeiro, 4348, Salvador - BA')

      # Act
      second_order.save!

      # Assert
      expect(second_order.id_code).not_to eq(first_order.id_code)
    end
  end
end
