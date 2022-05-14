require 'rails_helper'

# Conforme as funcionalidades forem evoluindo a página inicial pode ir sofrendo alterações.

describe 'Usuário vê a página inicial' do
  it 'e vê um título, uma mensagem de boas vindas e um menu de navegação' do
    # Arrange
  
    # Act
    visit root_path

    # Assert
    expect(page).to have_content('Sistema de Fretes')
    within('nav') do
      expect(page).to have_content('Transportadoras')
    end
    expect(page).to have_content('Bem vindo à Aplicação de Fretes')
  end

end