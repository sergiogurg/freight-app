require 'rails_helper'

describe 'Usuário de Tranportadora visita a tela de veículos' do
  it 'e não existem veículos' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    click_on 'Entrar'
    within('nav') do
      click_on 'Minha Transportadora'
    end
    click_on 'Veículos cadastrados'

    # Assert
    expect(page).to have_content('Nenhum veículo cadastrado.')

  end

  it 'e vê a tabela de veículos cadastrados' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: sc)
    Vehicle.create!(id_plate: 'XYZ-5678', make: 'Fiat', model: 'Ducato', year: '2020', load_capacity: 1378, shipping_company: sc)

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    click_on 'Entrar'
    within('nav') do
      click_on 'Minha Transportadora'
    end
    click_on 'Veículos cadastrados'

    # Assert
    expect(page).to have_content('Mercedez-Benz Sprinter 2022')
    expect(page).to have_content('ABC-1234')
    expect(page).to have_content('3500')
  end
end