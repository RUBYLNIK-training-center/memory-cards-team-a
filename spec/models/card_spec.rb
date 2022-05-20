require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:board) do
    Board.create(name: 'Anything', user_id: user.id)
  end

  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  let(:card) do
    described_class.create(question: 'Is it test?', answer: 'yep', board_id: board.id)
  end

  it 'is valid with valid attributes' do
    expect(card).to be_valid
  end

  it 'is not valid without a question' do
    card.question = nil
    expect(card).not_to be_valid
  end

  it 'is not valid without a answer' do
    card.answer = nil
    expect(card).not_to be_valid
  end
end
