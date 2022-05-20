require 'rails_helper'

describe 'Usuário de Transportadora se autentica (faz login)' do
  it 'na página de Login de Transportadora' do
    # Arrange
    User.create!(email: 'teste@fedex.com.br', password: 'fedex123')
    
    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end

    # Assert
    expect(current_path).to eq(new_user_session_path)
  end

  it 'com sucesso' do
    # Arrange
    User.create!(email: 'teste@fedex.com.br', password: 'fedex123')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    click_on 'Entrar'

    # Assert
    expect(page).to have_content('Login de Transportadora efetuado com sucesso.')
    expect(page).to have_content('teste@fedex.com.br')
    expect(page).not_to have_link('Fazer Login como Usuário')
    expect(page).to have_button('Sair')

  end

  it 'e faz logout' do
    # Arrange
    User.create!(email: 'teste@fedex.com.br', password: 'fedex123')

    # Act
    visit root_path
    within('nav') do
      click_on 'Fazer Login como Usuário'
    end
    fill_in 'E-mail', with: 'teste@fedex.com.br'
    fill_in 'Senha', with: 'fedex123'
    click_on 'Entrar'
    click_on 'Sair'

    # Assert
    expect(page).to have_content('Logout de Transportadora efetuado com sucesso.')
    expect(page).not_to have_content('teste@fedex.com.br')
    expect(page).not_to have_button('Sair')
    expect(page).to have_link('Fazer Login como Usuário')
  end

end