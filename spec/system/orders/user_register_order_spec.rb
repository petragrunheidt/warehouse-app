require 'rails_helper'

describe 'Usuário cadastra um pedido' do
  it 'e deve fazer login' do
    # Arrange

    # Act
      visit root_path
      click_on 'Registrar Pedido'
    # Assert
      expect(current_path).to eq new_user_session_path
  end
  it 'com sucesso' do
    # Arrange
    user = User.create!(name: 'Petra', email: 'petramail@gmail.com', password: 'password')
    Supplier.create!(corporate_name: 'PITR ltda', brand_name: 'Pitra', registration_number: '0329419300013',
      city: 'Pitropolis', state: 'RJ', email: 'pitramail', address: 'Rua da não Petra')
    sup = Supplier.create!(corporate_name: 'PETR ltda', brand_name: 'Petra', registration_number: '0039419300013',
      city: 'Petropolis', state: 'SP', email: 'petramail', address: 'Rua da Petra')
    Warehouse.create!(name: 'Ramal', code: 'SAM', address: 'rua da não petra',
      cep: '05000030', city: 'São Paulo',
      area: 520, description: 'descrição')
    war = Warehouse.create!(name: 'Rozali', code: 'RIO', address: 'rua da petra',
      cep: '25930030', city: 'Rio de Janeiro',
      area: 5320, description: 'descrição')
    # Act
      login_as(user)
      visit root_path
      click_on 'Registrar Pedido'
      select war.name, :from => 'Galpão'
      select sup.corporate_name, :from => 'Fornecedor'
      fill_in 'Data Prevista de Entrega', with: '20/12/2022'
      click_on 'Enviar'
    # Assert
    expect(page).to have_content 'Pedido registrado com sucesso.'
    expect(page).to have_content 'Galpão Destino: Rozali'
    expect(page).to have_content 'Fornecedor: PETR ltda'
    expect(page).to have_content 'Usuário Responsável: Petra <petramail@gmail.com>'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).not_to have_content 'PITR ltda'
  end
end