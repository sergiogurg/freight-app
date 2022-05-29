require 'rails_helper'

describe 'Usuário de Transportadora atualiza as informações de Rota' do
  # it 'a partir de um botão na página das Rotas de determinada Ordem de Serviço' do
  #   # Arrange


  #   # Act


  #   # Assert
  # end

  it 'com sucesso' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)

    vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: shipping_company)

    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company, vehicle: vehicle)

    route_update = RouteUpdate.create!(date: '28/05/2022', time: '10:41', current_location: 'Avenida Alberto Byington, 1933, São Paulo - SP', order: order)

    # Act
    login_as(user, :scope => :user)
    visit shipping_company_order_route_updates_path(shipping_company.id, order.id)
    click_on 'Atualizar Rota'
    fill_in 'Nova Localização', with: 'Rua Barão do Rio Branco, 922, Fortaleza - CE'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(shipping_company_order_route_updates_path(shipping_company.id, order.id))
    expect(page).to have_content('Rota atualizada com sucesso.')
    expect(page).to have_content('Localização atual: Avenida Alberto Byington, 1933, São Paulo - SP')
    expect(page).to have_content('Localização atual: Rua Barão do Rio Branco, 922, Fortaleza - CE')
  end

  it 'com o endereço do destinatário, automaticamente finalizando a Ordem de Serviço' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)

    vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: shipping_company)

    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company, vehicle: vehicle)

    route_update = RouteUpdate.create!(date: '28/05/2022', time: '10:41', current_location: 'Rua Padre Valdevino, 1880, Fortaleza - CE', order: order)

    # Act
    login_as(user, :scope => :user)
    visit new_shipping_company_order_route_update_path(shipping_company.id, order.id)
    fill_in 'Nova Localização', with: 'Rua Padre Valdevino, 1880, Fortaleza - CE'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('O produto foi entregue ao destinatário. Ordem de Serviço finalizada!')
  end
end