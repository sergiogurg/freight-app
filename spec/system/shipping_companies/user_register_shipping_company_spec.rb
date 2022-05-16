require 'rails_helper'

describe 'Usuário cadastra transportadora' do
  it 'a partir do menu inicial' do
    # Arrange

    # Act
    visit root_path
    click_on 'Transportadoras'
    click_on 'Cadastrar Nova Transportadora'

    # Assert 
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Domínio de Email'
    expect(page).to have_field 'Endereço'
    expect(page).to have_button 'Enviar'

  end
  
  it 'com sucesso' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Cadastrar Nova Transportadora'
    fill_in 'Razão Social', with: 'Fedex Brasil Logistica e Transporte LTDA'
    fill_in 'Nome Fantasia', with: 'FedEx'
    fill_in 'CNPJ', with: '10970887000285'
    fill_in 'Domínio de Email', with: '@fedex.com.br'
    fill_in 'Endereço', with: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('FedEx')
    expect(page).to have_content('Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('10970887000285')
  end

  # it 'com dados incompletos' do
  # end
end