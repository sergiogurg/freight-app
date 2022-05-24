require 'rails_helper'

describe 'Usuário de Transportadora edita um veículo' do
  it 'a partir da tela inicial' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)
    Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Minha Transportadora'
    end
    click_on 'Veículos cadastrados'
    click_on 'Mercedez-Benz Sprinter 2022'

    # Assert
    expect(page).to have_field('Placa')
    expect(page).to have_field('Marca')
    expect(page).to have_field('Modelo')
    expect(page).to have_field('Ano')
    expect(page).to have_field('Capacidade de carga')
  end

  it 'com sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)
    Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Minha Transportadora'
    end
    click_on 'Veículos cadastrados'
    click_on 'Mercedez-Benz Sprinter 2022'
    fill_in 'Placa', with: 'XYZ-5678'
    fill_in 'Marca', with: 'Fiat'
    fill_in 'Modelo', with: 'Ducato'
    fill_in 'Ano', with: '2020'
    fill_in 'Capacidade de carga', with: '1378'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Veículo atualizado com sucesso.')
    expect(page).to have_content('Fiat Ducato 2020')
    expect(page).to have_content('XYZ-5678')
    expect(page).to have_content('1378')
  end
end