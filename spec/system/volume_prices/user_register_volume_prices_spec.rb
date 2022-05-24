require 'rails_helper'

describe 'Usuário de Transportadora cria um referencial de preço por volume' do
  it 'a partir da tela inicial' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    click_on 'Minha Transportadora'
    click_on 'Tabela de Preços por Volume'
    click_on 'Cadastrar Intervalos de Volume'

    # Assert
    expect(page).to have_field('Volume inicial')
    expect(page).to have_field('Volume final')
    expect(page).to have_field('Preço-volume')
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
    click_on 'Tabela de Preços por Volume'
    click_on 'Cadastrar Intervalos de Volume'
    fill_in 'Volume inicial', with: 0
    fill_in 'Volume final', with: 0.250
    fill_in 'Preço-volume', with: 0.75
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(shipping_company_volume_prices_path(sc.id))
    expect(page).to have_content('Intervalo Preço-volume cadastrado com sucesso.')
  end
end