require 'rails_helper'

describe 'Usuario clica em fornecedores' do
    it 'E acessa a pagina de fornecedores' do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on('Fornecedores')
        end

        # Assert
        expect(current_path).to eq suppliers_path
    end

    it 'e vê lista de fornecedores' do
         # Arrange
         Supplier.create!(corporate_name: 'Petra', brand_name: 'PETR', registration_number: 493028304, 
                 city: 'Petropolis', state: 'SP', email: 'petramail')

         # Act
         visit root_path
         click_on('Fornecedores')
 
         # Assert
         expect(current_path).to eq suppliers_path
    end
    it 'e vê mensagem quando não há cadastros' do
        # Arrange
        
        # Act
        visit root_path
        click_on('Fornecedores')

        # Assert
        expect(current_path).to eq suppliers_path
        expect(page).to have_content('Não existem fornecedores cadastrados')
    end
end