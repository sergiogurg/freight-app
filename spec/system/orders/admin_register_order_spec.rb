require 'rails_helper'

describe 'Admin cadastra uma nova Ordem de Serviço' do
  it 'a partir do menu' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Ordens de Serviço'
    end
    click_on 'Cadastrar Nova Ordem de Serviço'

    # Assert
    expect(page).to have_content('Nova Ordem de Serviço')
    expect(page).to have_field('Endereço para retirada')
    expect(page).to have_field('Comprimento do produto')
    expect(page).to have_field('Altura do produto')
    expect(page).to have_field('Largura do produto')
    expect(page).to have_field('Peso do produto')
    expect(page).to have_field('Endereço de destino')
    expect(page).to have_select('Transportadora')
  end

  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    shipping_company = ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

    # Act
    login_as(admin, :scope => :admin)
    visit new_order_path
    fill_in 'Endereço para retirada', with: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP'
    fill_in 'Comprimento do produto', with: 115
    fill_in 'Altura do produto', with: 91
    fill_in 'Largura do produto', with: 76
    fill_in 'Peso do produto', with: 6.42
    fill_in 'Endereço de destino', with: 'Rua Padre Valdevino, 1880, Fortaleza - CE'
    select shipping_company.brand_name, from: 'Transportadora'
    click_on 'Enviar'
    
    # Assert
    expect(current_path).to eq(orders_path)
    expect(page).to have_content('Ordem de Serviço cadastrada com sucesso.')

  end
end