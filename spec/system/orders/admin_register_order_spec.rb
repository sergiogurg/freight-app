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

    # Act
    login_as(admin, :scope => :admin)
    visit new_order_path
    fill_in 'Endereço para retirada', with: 'Rodovia Presidente Dutra, Km 228, Guarulhos - SP'
    fill_in 'Comprimento do produto', with: 115
    fill_in 'Altura do produto', with: 91
    fill_in 'Largura do produto', with: 76
    fill_in 'Peso do produto', with: 6.42
    fill_in 'Endereço para retirada', with: 'Rua Padre Valdevino, 1880, Fortaleza - CE'
    
    # Assert

  end
end