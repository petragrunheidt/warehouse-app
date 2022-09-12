require 'rails_helper'

describe 'Usuário cadastra um galpão' do
    it 'a partir da tela inicial' do
        # Arrange

        # Act
        visit root_path
        click_on 'Cadastrar Galpão'

        # Assert
        expect(page).to have_field('Nome')
        expect(page).to have_field('Código')
        expect(page).to have_field('Cidade')
        expect(page).to have_field('Area')
        expect(page).to have_field('Endereço')
        expect(page).to have_field('CEP')
        expect(page).to have_field('Descrição')
    
    end

    it 'com sucesso' do
        # Arrange

        # Act
        visit root_path
        click_on 'Cadastrar Galpão'
        fill_in 'Nome', with: 'Rio de Janeiro'
        fill_in 'Código', with: 'RIO'
        fill_in 'Cidade', with: 'Rio de Janeiro'
        fill_in 'Area', with: '32_000'
        fill_in 'Endereço', with: 'Avenida do Museu do Amanhã, 1000'
        fill_in 'CEP', with: '20100-000'
        fill_in 'Descrição', with: 'Galpão da zona portuária do Rio'
        click_on 'Enviar'
        
        # Assert
        expect(current_path).to eq warehouse_path('1')
        expect(page).to have_content 'Rio de Janeiro'
        expect(page).to have_content 'RIO'
        expect(page).to have_content 'Galpão cadastrado com sucesso!'
    end
end