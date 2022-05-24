require 'rails_helper'

describe 'Usuário de Transportadora cria um referencial de prazos' do
  it 'a partir da tela inicial' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Intervalos de Distância'

    # Assert
    expect(page).to have_field('Distância inicial')
    expect(page).to have_field('Distância final')
    expect(page).to have_field('Dias úteis')
    expect(page).to have_button('Enviar')
  end

  it 'com sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Prazos'
    click_on 'Cadastrar Intervalos de Distância'
    fill_in 'Distância inicial', with: 0
    fill_in 'Distância final', with: 300
    fill_in 'Dias úteis', with: 2
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(shipping_company_delivery_times_path(sc.id))
    expect(page).to have_content('Intervalo de Prazos cadastrado com sucesso.')
  end
end