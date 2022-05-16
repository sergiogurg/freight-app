require 'rails_helper'

describe 'Usuário vê detalhes de uma transportadora' do
  it 'e vê informações adicionais' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'

    # Assert
    expect(page).to have_content('Transportadora FedEx')
    expect(page).to have_content('Razão Social: ')
    expect(page).to have_content('Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('CNPJ: ')
    expect(page).to have_content('10970887000285')
    expect(page).to have_content('Domínio de Email: ')
    expect(page).to have_content('@fedex.com.br')
    expect(page).to have_content('Endereço: ')
    expect(page).to have_content('Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
  end

  it 'e volta para a lista de transportadoras' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(shipping_companies_path)
  end
end