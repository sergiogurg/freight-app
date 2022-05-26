require 'rails_helper'

describe 'Admin cadastra uma nova Ordem de Serviço' do
  it 'a partir do menu' do
    # Arrange

    # Act
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

  # it 'com sucesso' do
  #   # Arrange


  #   # Act

    
  #   # Assert

  # end

  # it 'mas os campos obrigatórios estão vazios' do
  #   # Arrange


  #   # Act

    
  #   # Assert

  # end
end