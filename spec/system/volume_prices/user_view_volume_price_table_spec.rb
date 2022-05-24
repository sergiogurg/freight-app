require 'rails_helper'

describe 'Usuário de Transportadora vê a tabela de preços por volume' do
  it 'mas não há nenhum intervalo cadastrado' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços por Volume'

    # Assert
    expect(page).to have_content('Nenhum preço-volume cadastrado.')
  end

  it 'com sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)
    vol_price = VolumePrice.create!(initial_volume: 0, final_volume: 0.250, price: 0.75, shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços por Volume'

    # Assert
    expect(page).to have_content('Volume Inicial')
    expect(page).to have_content('0')
    expect(page).to have_content('Volume Final')
    expect(page).to have_content('0.25')
    expect(page).to have_content('Preço por km')
    expect(page).to have_content('0.75')

  end
end