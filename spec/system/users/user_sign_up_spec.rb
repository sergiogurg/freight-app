require 'rails_helper'

describe 'Usuário de Transportadora cria uma conta' do
  it 'mas o domínio de email não pertence a nenhuma Transportadora cadastrada' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    click_on 'Criar nova conta de Transportadora'
    fill_in 'E-mail', with: 'teste@aleatorio.com.br'
    fill_in 'Senha', with: 'aleatorio123'
    fill_in 'Confirme sua senha', with: 'aleatorio123'
    click_on 'Criar Conta'

    # Assert
    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('O domínio de email não pertence a nenhuma Transportadora.')
  end

  it 'e existe Tranportadora com domínio de email correspondente' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    click_on 'Criar nova conta de Transportadora'
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    fill_in 'Confirme sua senha', with: 'fedex123'
    click_on 'Criar Conta'
    
    # Assert
    expect(current_path).to eq(new_user_session_path)
    expect(page).to have_content('Bem vindo! Conta de Transportadora criada com sucesso.')

  end

  it 'mas já existe alguma conta com email igual' do
    # Arrange
    ShippingCompany.create!(corporate_name: 'Fedex Brasil Logistica e Transporte LTDA', brand_name: 'FedEx', registration_number: '10970887000285', email_domain: '@fedex.com.br', address: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP')
    sc = ShippingCompany.last
    User.create!(email: 'teste@fedex.com.br', password: 'fedex123', shipping_company: sc)

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    click_on 'Criar nova conta de Transportadora'
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'hahahahaha'
    fill_in 'Confirme sua senha', with: 'hahahahaha'
    click_on 'Criar Conta'

    # Assert
    expect(current_path).to eq(new_user_registration_path)
    expect(page).to have_content('Erro ao criar conta de Transportadora.')
  end
end