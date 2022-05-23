require 'rails_helper'

describe 'Admin vê detalhes de uma transportadora' do
  it 'e vê informações adicionais' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Admin'
    end
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'admin123'
    click_on 'Entrar'
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'

    # Assert
    expect(page).to have_content('Transportadora FedEx')
    expect(page).to have_content('Razão Social: ')
    expect(page).to have_content('Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('CNPJ: ')
    expect(page).to have_content('10970887000285')
    expect(page).to have_content('Domínio de Email: ')
    expect(page).to have_content('@fedex.com.br')
    expect(page).to have_content('Endereço: ')
    expect(page).to have_content('Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
  end

  it 'e volta para a lista de transportadoras' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Admin'
    end
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'admin123'
    click_on 'Entrar'
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'FedEx'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(shipping_companies_path)
  end
end

describe 'Usuário de uma Transportadora vê detalhes' do
  it 'de sua própria Transportadora, com sucesso' do
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

    # Assert
    expect(page).to have_content('Transportadora FedEx')
    expect(page).to have_content('Razão Social: Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('CNPJ: 10970887000285')
    expect(page).to have_content('Domínio de Email: @fedex.com.br')
    expect(page).to have_content('Endereço: Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
  end

  it 'de uma Transportadora diferente, sem sucesso' do
    # Arrange
    sc = ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    click_on 'Entrar'
    visit 'shipping_companies/2'

    # Assert
    expect(page).to have_content('Usuário, você foi redirecionado por tentar visualizar outra Transportadora.')
  end
end