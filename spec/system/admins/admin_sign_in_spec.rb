require 'rails_helper'

describe 'Usuário de Administrador se autentica (faz login)' do
  it 'na página de login de Admin' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Admin'
    end

    # Assert
    expect(current_path).to eq(new_admin_session_path)
  end

  it 'com sucesso' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Admin'
    end
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'admin123'
    click_on 'Entrar'

    # Assert
    expect(page).to have_content('Login de Admin efetuado com sucesso.')
    expect(page).not_to have_link('Fazer Login como Admin')
    expect(page).to have_button('Sair')
    expect(page).to have_content('teste@sistemadefrete.com.br')
  end

  it 'e faz logout' do
    # Arrange
    Admin.create!(email: 'teste@sistemadefrete.com.br', password: 'admin123')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Admin'
    end
    fill_in 'E-mail', with: 'teste@sistemadefrete.com.br'
    fill_in 'Senha', with: 'admin123'
    click_on 'Entrar'
    click_on 'Sair'

    # Assert
    expect(page).to have_content('Logout de Admin efetuado com sucesso.')
    expect(page).to have_link('Fazer Login como Admin')
    expect(page).not_to have_button('Sair')
    expect(page).not_to have_content('teste@sistemadefrete.com.br')
  end
  
end