require 'rails_helper'

describe 'Usuário de Transportadora cadastra veículo' do
  it 'a partir da tela inicial' do
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
    click_on 'Cadastrar Novo Veículo'

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
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Placa', with: 'ABC-1234'
    fill_in 'Marca', with: 'Mercedez-Benz'
    fill_in 'Modelo', with: 'Sprinter'
    fill_in 'Ano', with: '2022'
    fill_in 'Capacidade de carga', with: '3500'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Veículo cadastrado com sucesso.')
  end

  it 'com dados incompletos e falha' do
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
    click_on 'Cadastrar Novo Veículo'
    fill_in 'Placa', with: ''
    fill_in 'Marca', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Ano', with: ''
    fill_in 'Capacidade de carga', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Placa não pode ficar em branco')
    expect(page).to have_content('Marca não pode ficar em branco')
    expect(page).to have_content('Modelo não pode ficar em branco')
    expect(page).to have_content('Ano não pode ficar em branco')
    expect(page).to have_content('Capacidade de carga não pode ficar em branco')
  end
end