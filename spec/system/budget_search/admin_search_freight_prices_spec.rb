require 'rails_helper'

describe 'Administrador realiza consulta de preços' do
  it 'a partir do menu' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Consulta de Orçamento'
    end

    # Assert
    expect(page).to have_content('Consulta de Orçamento')
    expect(page).to have_field('Comprimento')
    expect(page).to have_field('Altura')
    expect(page).to have_field('Largura')
    expect(page).to have_field('Peso')
    expect(page).to have_field('Distância')
    expect(page).to have_button('Calcular Fretes')
  end

  # it 'com sucesso' do
  #   # Arrange Admin
  #   admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

  #   # Arrange Transportadora 1
  #   ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

  #   volume_prices
  #   weight_prices
  #   delivery_times

  #   # Transportadora 2 ...

  #   # Transportadora 3 ...

  #   # Act
  #   login_as(admin, :scope => :admin)
  #   visit root_path
  #   within('nav') do
  #     click_on 'Consulta de Orçamento'
  #   end
  #   fill_in 'Comprimento', with: 90
  #   fill_in 'Altura', with: 60
  #   fill_in 'Largura', with: 15
  #   fill_in 'Peso', with: 6.42
  #   fill_in 'Distância', with: 183
  #   click_on 'Calcular Fretes'

  #   # Assert
  #   expect(page).to have_link('Transportadora 1')
  #   expect(page).to have_link('Transportadora 2')
  #   expect(page).to have_link('Transportadora 3')
  # end
end