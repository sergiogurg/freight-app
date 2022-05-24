require 'rails_helper'

describe 'Usuário de Transportadora vê a tabela de prazos' do
  it 'mas não há nenhum intervalo cadastrado' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Prazos'

    # Assert
    expect(page).to have_content('Nenhum intervalo cadastrado.')
  end

  it 'com sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)
    del_time = DeliveryTime.create!(initial_distance: 0, final_distance: 100, weekdays: 2, shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Prazos'

    # Assert
    expect(page).to have_content('Distância Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('Distância Final')
    expect(page).to have_content('100')
    expect(page).to have_content('Dias Úteis')
    expect(page).to have_content('2')
  end
end