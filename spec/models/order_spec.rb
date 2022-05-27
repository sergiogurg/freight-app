require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'gera um código automaticamente' do
    it 'antes de ser validado' do
      # Arrange
      order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE')

      # Act
      order.save!
      result = order.id_code

      # Assert
      expect(result).not_to be_empty
      expect(result.length).to eq(15)
    end

    it 'e ele é aleatório' do
      # Arrange
      first_order = Order.create!(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE')
      second_order = order = Order.new(origin_address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP', product_length: 50, product_height: 35, product_width: 10, product_weight: 4.76, destination_address: 'Av. Aliomar Baleeiro, 4348, Salvador - BA')

      # Act
      second_order.save!

      # Assert
      expect(second_order.id_code).not_to eq(first_order.id_code)
    end
    
    context '#valid?' do
      it 'Falso quando o Endereço para retirada (origin_address) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: '', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando o Comprimento do produto (product_length) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: nil, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando a Altura do produto (product_height) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: nil, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando a Largura do produto (product_width) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: 91, product_width: nil, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando o Peso do produto (product_weight) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: 91, product_width: 76, product_weight: nil, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando o Endereço de destino (destination_address) estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: '', status: 0)

        # Act and Assert
        expect(order).not_to be_valid
      end

      it 'Falso quando o status estiver em branco' do
        # Arrange
        order = Order.new(origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', id_code: '82P5D8BSAJQBARI', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', status: nil)

        # Act and Assert
        expect(order).not_to be_valid
      end

    end
  end
end
