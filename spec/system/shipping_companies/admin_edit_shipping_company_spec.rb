require 'rails_helper'

describe 'Admin edita uma transportadora' do
  it 'a partir da tela inicial' do
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
    click_on 'Editar'
    
    # Assert
    expect(page).to have_content('Editar Transportadora')
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Domínio de Email'
    expect(page).to have_field 'Endereço'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do
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
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Embraen Empresa Brasileira de Transportes Eireli'
    fill_in 'Nome Fantasia', with: 'Embraen'
    fill_in 'CNPJ', with: '04512172000103'
    fill_in 'Domínio de Email', with: '@embraen.com.br'
    fill_in 'Endereço', with: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP'
    click_on 'Enviar'

    # Assert
    expect(current_path).to eq(shipping_company_path(ShippingCompany.find_by(brand_name: 'Embraen').id))

    expect(page).to have_content('Transportadora atualizada com sucesso')
    expect(page).to have_content('Transportadora Embraen')
    expect(page).to have_content('Razão Social: ')
    expect(page).to have_content('Embraen Empresa Brasileira de Transportes Eireli')
    expect(page).to have_content('CNPJ: ')
    expect(page).to have_content('04512172000103')
    expect(page).to have_content('Domínio de Email: ')
    expect(page).to have_content('@embraen.com.br')
    expect(page).to have_content('Endereço: ')
    expect(page).to have_content('Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')
    
  end

  it 'e não salva campos em branco' do
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
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Domínio de Email', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível atualizar a transportadora')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Domínio de Email não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end

  it 'e não salva campos já em uso por outra' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    ShippingCompany.create!(corporate_name: 'Embraen Empresa Brasileira de Transportes Eireli', brand_name: 'Embraen', registration_number: '04512172000103', email_domain: '@embraen.com.br', address: 'Rua Doutor João Marques Mauricio, 278, Embu das Artes - SP')

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
    click_on 'Embraen'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Fedex Brasil Logistica e Transporte LTDA'
    fill_in 'CNPJ', with: '10970887000285'
    fill_in 'Domínio de Email', with: '@fedex.com.br'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível atualizar a transportadora')
    expect(page).to have_content('Razão Social já está em uso')
    expect(page).to have_content('CNPJ já está em uso')
    expect(page).to have_content('Domínio de Email já está em uso')
  end
end