require 'rails_helper'

describe 'Usuário de Transportadora vê as Ordens de Serviço encaminhadas a ela' do
  it 'a partir do menu' do
    # Arrange
    shipping_company = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    user = User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: shipping_company)
    order = Order.create!(id_code: 'VWJGX1FHUHENKC6', origin_address: 'Avenida Alberto Byington, 1933, São Paulo - SP', product_length: 115, product_height: 91, product_width: 76, product_weight: 6.42, destination_address: 'Rua Padre Valdevino, 1880, Fortaleza - CE', shipping_company: shipping_company)

    # Act
    login_as(user, :scope => :user)
    visit root_path
    within('nav') do
      click_on 'Minhas Ordens de Serviço'
    end

    # Assert
    expect(page).to have_content('Ordens de Serviço da Transportadora FedEx')
    expect(page).to have_content('Código')
    expect(page).to have_content('VWJGX1FHUHENKC6')
    expect(page).to have_content('Status')
    expect(page).to have_content('pending')
    expect(page).to have_content('Endereço de Origem')
    expect(page).to have_content('Avenida Alberto Byington, 1933, São Paulo - SP')
    expect(page).to have_content('Endereço de Destino')
    expect(page).to have_content('Rua Padre Valdevino, 1880, Fortaleza - CE')
    expect(page).to have_content('Detalhes')
    expect(page).to have_link('Ver Detalhes')
  end
end