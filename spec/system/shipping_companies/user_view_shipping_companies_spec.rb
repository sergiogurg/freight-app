require 'rails_helper'

describe 'Usuário visita a tela de transportadoras' do
  it 'e não existem transportadoras cadastradas' do
    # Arrange

    # Act
    visit root_path
    within('nav') do
      click_on 'Transportadoras'
    end

    # Assert
    expect(page).to have_content('Nenhuma transportadora cadastrada')
  end

#   it 'e vê as transportadoras cadastradas' do
#     # Arrange

#     # Act

#     # Assert

#   end
end
