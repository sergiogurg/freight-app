require 'rails_helper'

describe 'Usuário de Transportadora vê a tabela de preços por peso' do
  it 'mas não há nenhum intervalo cadastrado' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços por Peso'

    # Assert
    expect(page).to have_content('Nenhum preço-peso cadastrado.')
  end

  it 'com sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)
    wht_price = WeightPrice.create!(initial_weight: 0, final_weight: 5.0, price: 0.35, shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços por Peso'

    # Assert
    expect(page).to have_content('Peso Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('Peso Final')
    expect(page).to have_content('5.0')
    expect(page).to have_content('Preço por km')
    expect(page).to have_content('0.35')

  end
end