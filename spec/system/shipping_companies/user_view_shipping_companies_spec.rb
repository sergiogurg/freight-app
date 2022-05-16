require 'rails_helper'

describe 'Usuário visita a tela de transportadoras' do
  it 'e não existem transportadoras cadastradas' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    # Assert
    expect(page).to have_content('Nenhuma transportadora cadastrada')
  end

  it 'e vê a lista de transportadoras cadastradas' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    # Assert
    expect(page).to have_content('FedEx')
    expect(page).to have_content('Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('CNPJ: 10970887000285')
    expect(page).to have_content('Embraen')
    expect(page).to have_content('Embraen Empresa Brasileira de Transportes Eireli')
    expect(page).to have_content('CNPJ: 04512172000103')

  end
end
