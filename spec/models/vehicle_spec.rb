require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'falso quando a Placa (id_plate) estiver em branco' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        vehicle = Vehicle.new(id_plate: '', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando a Marca (make) estiver em branco' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        vehicle = Vehicle.new(id_plate: 'ABC-1234', make: '', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando o Modelo (model) estiver em branco' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        vehicle = Vehicle.new(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: '', year: '2022', load_capacity: 3500, shipping_company: sc)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando o Ano (year) estiver em branco' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        vehicle = Vehicle.new(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '', load_capacity: 3500, shipping_company: sc)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando a Capacidade de Carga (load_capacity) estiver em branco' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        vehicle = Vehicle.new(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: '', shipping_company: sc)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end

      it 'falso quando a Transportadora (shipping_company) estiver em branco' do
        # Arrange
        vehicle = Vehicle.new(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: nil)

        # Act and Assert
        expect(vehicle).not_to be_valid
      end
    end

    context 'uniqueness' do
      it 'falso quando a Placa (id_plate) já estiver em uso' do
        # Arrange
        sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        first_vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)
        second_vehicle = Vehicle.new(id_plate: 'ABC-1234', make: 'Fiat', model: 'Ducato', year: '2020', load_capacity: 1378, shipping_company: sc)

        # Act and Assert
        expect(second_vehicle).not_to be_valid
      end
    end
  end
end
