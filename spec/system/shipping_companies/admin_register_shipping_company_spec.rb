require 'rails_helper'

describe 'Admin cadastra transportadora' do

  it 'e volta para a lista de transportadoras' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Cadastrar Nova Transportadora'
    click_on 'Voltar'

    # Assert
    expect(current_path).to eq(shipping_companies_path)
  end

  it 'a partir do menu inicial' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Cadastrar Nova Transportadora'

    # Assert 
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Domínio de Email'
    expect(page).to have_field 'Endereço'
    expect(page).to have_button 'Enviar'

  end
  
  it 'com sucesso' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Cadastrar Nova Transportadora'
    fill_in 'Razão Social', with: 'Fedex Brasil Logistica e Transporte LTDA'
    fill_in 'Nome Fantasia', with: 'FedEx'
    fill_in 'CNPJ', with: '10970887000285'
    fill_in 'Domínio de Email', with: '@fedex.com.br'
    fill_in 'Endereço', with: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP'
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Transportadora cadastrada com sucesso')
    expect(page).to have_content('FedEx')
    expect(page).to have_content('Fedex Brasil Logistica e Transporte LTDA')
    expect(page).to have_content('10970887000285')
  end

  it 'sem preencher os campos de dados' do
    # Arrange
    admin = Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    login_as(admin, :scope => :admin)
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end
    click_on 'Cadastrar Nova Transportadora'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Domínio de Email', with: ''
    fill_in 'Endereço', with: ''
    click_on 'Enviar'

    # Assert
    expect(page).to have_content('Não foi possível cadastrar a transportadora')
    expect(page).to have_content('Nome Fantasia não pode ficar em branco')
    expect(page).to have_content('CNPJ não pode ficar em branco')
    expect(page).to have_content('Domínio de Email não pode ficar em branco')
    expect(page).to have_content('Endereço não pode ficar em branco')
  end
end