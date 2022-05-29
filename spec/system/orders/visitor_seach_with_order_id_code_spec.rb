require 'rails_helper'

describe 'De posse do código de identificação id_code, um Visitante consulta o status de uma Ordem de Serviço e informações de suas Rotas' do
  it 'a partir do menu' do
    # Arrange


    # Act
    visit root_path
    within('nav') do
      click_on 'Rastreamento de Entrega'
    end

    # Assert
    expect(page).to have_content('Consulta de Entrega')
    expect(page).to have_field('Código de Rastreamento')
    expect(page).to have_button('Buscar')
  end

end