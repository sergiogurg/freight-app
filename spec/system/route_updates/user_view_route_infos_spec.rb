require 'rails_helper'

describe 'Usuário de Transportadora vê informações de Rotas' do
  it 'a partir do menu' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)

    vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: shipping_company)

    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Minhas Ordens de Serviço'
    end
    click_on 'Ver Detalhes'
    click_on 'Aprovar'
    select 'Sprinter', from: 'Veículo'
    click_on 'Vincular Veículo'
    click_on 'Rota de entrega'

    # Assert
    expect(page).to have_content('Rotas da Ordem VWJGX1FHUHENKC6')
    expect(page).to have_content('Data')
    expect(page).to have_content(Time.now.strftime("%d/%m/%Y"))
    expect(page).to have_content('Hora')
    expect(page).to have_content(Time.now.strftime("%H:%M"))
    expect(page).to have_content('ocalização atual')
    expect(page).to have_content('Avenida Alberto Byington, 1933, São Paulo - SP')
  end
end