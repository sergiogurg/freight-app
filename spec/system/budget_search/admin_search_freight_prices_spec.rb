require 'rails_helper'

describe 'Administrador realiza consulta de preços' do
  it 'a partir do menu' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Consulta de Preços'
    end

    # Assert
    expect(page).to have_content('Consulta de Preços')
    expect(page).to have_field('Comprimento')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Largura')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Distância')
    expect(page).to have_button('Calcular Fretes')
  end

  it 'mas não há nenhuma Transportadora cadastrada' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Consulta de Preços'
    end
    fill_in 'Comprimento', with: 115
    fill_in 'Altura', with: 91
    fill_in 'Largura', with: 76
    fill_in 'Peso', with: 6.42
    fill_in 'Distância', with: 183
    click_on 'Calcular Fretes'

    # Assert
    expect(page).to have_content('Nenhuma Transportadora cadastrada.')
    expect(page).not_to have_css('table')
  end

  it 'mas nenhuma Transportadora atende aos requisitos da entrega' do
    # Arrange Admin
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Arrange Transportadora 1
    first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    VolumePrice.create!(initial_volume: 0, final_volume: 0.250, price: 0.75, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.251, final_volume: 0.500, price: 1.40, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.501, final_volume: 0.750, price: 1.90, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.751, final_volume: 1.000, price: 2.50, shipping_company: first_sc)

    WeightPrice.create!(initial_weight: 0, final_weight: 5.00, price: 0.350, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 5.01, final_weight: 10.00, price: 0.80, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 10.01, final_weight: 15.00, price: 1.55, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 15.01, final_weight: 20.00, price: 2.10, shipping_company: first_sc)

    DeliveryTime.create!(initial_distance: 0.0, final_distance: 100.0, weekdays: 2, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 100.1, final_distance: 300.0, weekdays: 5, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 300.1, final_distance: 500.0, weekdays: 8, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 500.1, final_distance: 800.0, weekdays: 14, shipping_company: first_sc)
    
    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Consulta de Preços'
    end
    fill_in 'Comprimento', with: 99_999
    fill_in 'Altura', with: 99_999
    fill_in 'Largura', with: 99_999
    fill_in 'Peso', with: 99_999
    fill_in 'Distância', with: 99_999
    click_on 'Calcular Fretes'

    # Assert
    # within('main div') do
      expect(page).to have_content('Nenhuma Transportadora atendeu aos requisitos.')
    # end
  end

  it 'e cada Transportadora mostra o seu orçamento e o seu prazo de entrega' do
    # Arrange Admin
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Arrange Transportadora 1
    first_sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    VolumePrice.create!(initial_volume: 0, final_volume: 0.250, price: 0.75, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.251, final_volume: 0.500, price: 1.40, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.501, final_volume: 0.750, price: 1.90, shipping_company: first_sc)
    VolumePrice.create!(initial_volume: 0.751, final_volume: 1.000, price: 2.50, shipping_company: first_sc)

    WeightPrice.create!(initial_weight: 0, final_weight: 5.00, price: 0.350, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 5.01, final_weight: 10.00, price: 0.80, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 10.01, final_weight: 15.00, price: 1.55, shipping_company: first_sc)
    WeightPrice.create!(initial_weight: 15.01, final_weight: 20.00, price: 2.10, shipping_company: first_sc)

    DeliveryTime.create!(initial_distance: 0.0, final_distance: 100.0, weekdays: 2, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 100.1, final_distance: 300.0, weekdays: 5, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 300.1, final_distance: 500.0, weekdays: 8, shipping_company: first_sc)
    DeliveryTime.create!(initial_distance: 500.1, final_distance: 800.0, weekdays: 14, shipping_company: first_sc)

    # Arrange Transportadora 2
    second_sc = ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

    VolumePrice.create!(initial_volume: 0, final_volume: 0.650, price: 0.40, shipping_company: second_sc)
    VolumePrice.create!(initial_volume: 0.651, final_volume: 1.050, price: 0.90, shipping_company: second_sc)
    VolumePrice.create!(initial_volume: 1.051, final_volume: 1.610, price: 1.30, shipping_company: second_sc)
    VolumePrice.create!(initial_volume: 1.611, final_volume: 1.880, price: 1.80, shipping_company: second_sc)

    WeightPrice.create!(initial_weight: 0, final_weight: 7.00, price: 0.60, shipping_company: second_sc)
    WeightPrice.create!(initial_weight: 7.01, final_weight: 14.00, price: 0.90, shipping_company: second_sc)
    WeightPrice.create!(initial_weight: 14.01, final_weight: 21.00, price: 1.25, shipping_company: second_sc)
    WeightPrice.create!(initial_weight: 21.01, final_weight: 28.00, price: 1.95, shipping_company: second_sc)

    DeliveryTime.create!(initial_distance: 0.0, final_distance: 200.0, weekdays: 4, shipping_company: second_sc)
    DeliveryTime.create!(initial_distance: 200.1, final_distance: 400.0, weekdays: 7, shipping_company: second_sc)
    DeliveryTime.create!(initial_distance: 400.1, final_distance: 600.0, weekdays: 11, shipping_company: second_sc)
    DeliveryTime.create!(initial_distance: 600.1, final_distance: 800.0, weekdays: 16, shipping_company: second_sc)

    # Arrange Transportadora 3
    third_sc = ShippingCompany.create!(corporate_name: 'Transportadora Route LTDA', brand_name: 'Route', registration_number: '12787399001072', email_domain: '@route.com.br', address: 'Rua Barão Do Rio Branco, 2027, Fortaleza - CE')

    VolumePrice.create!(initial_volume: 0, final_volume: 0.500, price: 0.75, shipping_company: third_sc)
    VolumePrice.create!(initial_volume: 0.501, final_volume: 1.000, price: 1.25, shipping_company: third_sc)
    VolumePrice.create!(initial_volume: 1.001, final_volume: 1.500, price: 1.75, shipping_company: third_sc)
    VolumePrice.create!(initial_volume: 1.500, final_volume: 2.000, price: 2.25, shipping_company: third_sc)

    WeightPrice.create!(initial_weight: 0, final_weight: 9.00, price: 1.10, shipping_company: third_sc)
    WeightPrice.create!(initial_weight: 9.01, final_weight: 18.00, price: 1.70, shipping_company: third_sc)
    WeightPrice.create!(initial_weight: 18.01, final_weight: 27.00, price: 2.20, shipping_company: third_sc)
    WeightPrice.create!(initial_weight: 27.01, final_weight: 36.00, price: 3.00, shipping_company: third_sc)

    DeliveryTime.create!(initial_distance: 0, final_distance: 250.0, weekdays: 5, shipping_company: third_sc)
    DeliveryTime.create!(initial_distance: 250.1, final_distance: 500.0, weekdays: 11, shipping_company: third_sc)
    DeliveryTime.create!(initial_distance: 500.1, final_distance: 750.0, weekdays: 14, shipping_company: third_sc)
    DeliveryTime.create!(initial_distance: 750.1, final_distance: 1000.0, weekdays: 19, shipping_company: third_sc)

    # Arrange Transportadora 4
    forth_sc = ShippingCompany.create!(corporate_name: 'Transportadora Tressi LTDA', brand_name: 'Tressi', registration_number: '00651266000102', email_domain: '@tressi.com.br', address: 'Avenida José João Muraro, 1514, Toledo - PR')

    VolumePrice.create!(initial_volume: 0, final_volume: 0.800, price: 0.90, shipping_company: forth_sc)
    VolumePrice.create!(initial_volume: 0.801, final_volume: 1.600, price: 1.70, shipping_company: forth_sc)
    VolumePrice.create!(initial_volume: 1.601, final_volume: 2.400, price: 2.45, shipping_company: forth_sc)
    VolumePrice.create!(initial_volume: 2.401, final_volume: 3.200, price: 3.10, shipping_company: forth_sc)

    WeightPrice.create!(initial_weight: 0, final_weight: 10.00, price: 1.20, shipping_company: forth_sc)
    WeightPrice.create!(initial_weight: 10.01, final_weight: 20.00, price: 1.70, shipping_company: forth_sc)
    WeightPrice.create!(initial_weight: 20.01, final_weight: 30.00, price: 2.40, shipping_company: forth_sc)
    WeightPrice.create!(initial_weight: 30.01, final_weight: 40.00, price: 3.00, shipping_company: forth_sc)

    DeliveryTime.create!(initial_distance: 0, final_distance: 300.0, weekdays: 6, shipping_company: forth_sc)
    DeliveryTime.create!(initial_distance: 300.1, final_distance: 600.0, weekdays: 10, shipping_company: forth_sc)
    DeliveryTime.create!(initial_distance: 600.1, final_distance: 900.0, weekdays: 16, shipping_company: forth_sc)
    DeliveryTime.create!(initial_distance: 900.1, final_distance: 1200.0, weekdays: 21, shipping_company: forth_sc)

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Consulta de Preços'
    end
    fill_in 'Comprimento', with: 115
    fill_in 'Altura', with: 91
    fill_in 'Largura', with: 76
    # Resultado do volume com 1.15*0.91*0.76 => volume = 0.79534 m³
    fill_in 'Peso', with: 6.42
    fill_in 'Distância', with: 183
    click_on 'Calcular Fretes'

    # Assert
    expect(page).to have_content('Transportadora')
    expect(page).to have_content('FedEx')
    expect(page).to have_content('Embraen')
    expect(page).to have_content('Route')
    expect(page).to have_content('Tressi')

    expect(page).to have_content('Orçamento')

    expect(page).to have_content('Prazo de Entrega')
  end
end