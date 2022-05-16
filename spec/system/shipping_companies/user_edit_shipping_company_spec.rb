require 'rails_helper'

describe 'Usuário edita uma transportadora' do
  it 'a partir da tela inicial' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'
    click_on 'Editar'
    
    # Assert
    expect(page).to have_content('Editar Transportadora')
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Domínio de Email'
    expect(page).to have_field 'Endereço'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Embraen Empresa Brasileira de Transportes Eireli'
    fill_in 'Nome Fantasia', with: 'Embraen'
    fill_in 'CNPJ', with: '04512172000103'
    fill_in 'Domínio de Email', with: '@embraen.com.br'
    fill_in 'Endereço', with: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(shipping_company_path(ShippingCompany.find_by(brand_name: 'Embraen').id))

    expect(page).to have_content('Transportadora atualizada com sucesso')
    expect(page).to have_content('Transportadora Embraen')
    expect(page).to have_content('Razão Social: ')
    expect(page).to have_content('Embraen Empresa Brasileira de Transportes Eireli')
    expect(page).to have_content('CNPJ: ')
    expect(page).to have_content('04512172000103')
    expect(page).to have_content('Domínio de Email: ')
    expect(page).to have_content('@embraen.com.br')
    expect(page).to have_content('Endereço: ')
    expect(page).to have_content('Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')
    
  end

  # it 'e mantém os campos obrigatórios' do
  #   # Arrange

  #   # Act

  #   # Assert

  # end
end