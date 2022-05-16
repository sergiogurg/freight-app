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

  # it 'com sucesso' do
  #   # Arrange

  #   # Act

  #   # Assert

  # end

  # it 'e mantém os campos obrigatórios' do
  #   # Arrange

  #   # Act

  #   # Assert

  # end
end