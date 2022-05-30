require 'rails_helper'

describe 'De posse do código de identificação id_code, um Visitante consulta o status de uma Ordem de Serviço e informações de suas Rotas' do
  it 'a partir do menu' do
    # Arrange


    # Act
    visit root_path
    within('nav') do
      click_on 'Rastreamento de Entrega'
    end

    # Assert
    expect(page).to have_content('Consulta de Entrega')
    expect(page).to have_field('Código de Rastreamento')
    expect(page).to have_button('Buscar')
  end

  it 'com sucesso' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company)

    first_route_update = RouteUpdate.create!(date: '28/05/2022', time: '10:41', current_location: 'Avenida Alberto Byington, 1933, São Paulo - SP', order: order)

    second_route_update = RouteUpdate.create!(date: '04/06/2022', time: '17:23', current_location: 'Rua dos Tupis, 317, Belo Horizonte - MG', order: order)

    # Act
    visit tracking_form_shipping_companies_path
    fill_in 'Código de Rastreamento', with: 'VWJGX1FHUHENKC6'
    click_on 'Buscar'

    # Assert
    expect(page).to have_content('Status')
    expect(page).to have_content('Endereço de origem')
    expect(page).to have_content('Endereço de destino')
    expect(page).to have_content('Data')
    expect(page).to have_content('Hora')
    expect(page).to have_content('Localização')
    expect(page).to have_content('Avenida Alberto Byington, 1933, São Paulo - SP')
    expect(page).to have_content('Rua dos Tupis, 317, Belo Horizonte - MG')
  end

  # it 'mas não existe Ordem de Serviço correspondente' do
  #   # Arrange


  #   # Act


  #   # Assert
  # end
end