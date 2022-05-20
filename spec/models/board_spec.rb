require 'rails_helper'

RSpec.describe Board, type: :model do
  subject(:board) do
    described_class.new(name: 'Anything', user_id: user.id)
  end

  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  it 'is valid with valid attributes' do
    expect(board).to be_valid
  end

  it 'is not valid without a name' do
    board.name = nil
    expect(board).not_to be_valid
  end
end
