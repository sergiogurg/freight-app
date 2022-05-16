require 'rails_helper'

RSpec.describe ShippingCompany, type: :model do

  describe '#valid?' do
    context 'presence' do
      it 'falso quando a Razão Social (corporate_name) estiver em branco' do
        # Arrange
        sc = ShippingCompany.new(corporate_name: '', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        # Act and Assert
        expect(sc).not_to be_valid
      end

      it 'falso quando o Nome Fantasia (brand_name) estiver em branco' do
        # Arrange
        sc = ShippingCompany.new(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: '', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        # Act and Assert
        expect(sc).not_to be_valid
      end

      it 'falso quando o CNPJ (registration_number) estiver em branco' do
        # Arrange
        sc = ShippingCompany.new(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        # Act and Assert
        expect(sc).not_to be_valid
      end

      it 'falso quando o Domínio de Email (email_domain) estiver em branco' do
        # Arrange
        sc = ShippingCompany.new(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

        # Act and Assert
        expect(sc).not_to be_valid
      end

      it 'falso quando o Endereço (address) estiver em branco' do
        # Arrange
        sc = ShippingCompany.new(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: '')

        # Act and Assert
        expect(sc).not_to be_valid
      end
    end

    context 'uniqueness' do
      it 'falso quando a Razão Social (corporate_name) já estiver em uso' do
        # Arrange
        first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
        second_sc = ShippingCompany.new(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')
  
        # Act and Assert
        expect(second_sc).not_to be_valid
      end

      it 'falso quando o CNPJ (registration_number) já estiver em uso' do
        # Arrange
        first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10010010010010', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
        second_sc = ShippingCompany.new(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '10010010010010', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')
  
        # Act and Assert
        expect(second_sc).not_to be_valid
      end

      it 'falso quando o Domínio de Email (email_domain) já estiver em uso' do
        # Arrange
        first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
        second_sc = ShippingCompany.new(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@fedex.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')
  
        # Act and Assert
        expect(second_sc).not_to be_valid
      end
    end

  end

end
