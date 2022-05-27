require 'rails_helper'

describe 'Usuário de Transportadora interage com a Ordem de Serviço' do
  # it 'e clica no botão "Ver Detalhes" a partir do menu' do
  #   # Arrange

  #   # Act

  #   # Assert

  # end

  # it 'e a rejeita' do
  #   # Arrange
  #   shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
  #   user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)
  #   order = order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company)

  #   # Act
  #   visit shipping_company_order_path(shipping_company.id, order.id)
  #   click_on 'Rejeitar'

  #   # Assert
  #   expect(page).to have_content('Status')
  #   expect(page).to have_content('rejected')
  # end

  it 'realiza a aprovação e vincula um Veículo' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)

    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company)

    vehicle = Vehicle.create!(id_plate: 'ABC-1234', make: 'Mercedez-Benz', model: 'Sprinter', year: '2022', load_capacity: 3500, shipping_company: shipping_company)

    # Act
    login_as(user, :scope => :user)
    visit shipping_company_order_path(shipping_company.id, order.id)
    click_on 'Aprovar'
    select 'Sprinter', from: 'Veículo'
    click_on 'Vincular Veículo'

    # Assert
    #   status da ordem passe a ser approved
    #   usuario deve escolher o veiculo
    #   ordem recebe uma instancia do model de atualizacao de rota (route_update)
    expect(page).to have_content('Transportadora FedEx: Ordem de Serviço VWJGX1FHUHENKC6')
    #   dá pra ver os detalhes da ordem
    expect(page).to have_content('Status')
    expect(page).to have_content('approved')
    expect(page).to have_content('Veículo')
    expect(page).to have_content('Mercedez-Benz Sprinter 2022')

  end
end