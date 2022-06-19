require 'rails_helper'

RSpec.describe AjaxController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  before do
    sign_in user
  end

  describe 'PUTCH change_confidence_level' do
    it 'changes confidence level' do
      board = Board.create(user_id: user.id, name: 'test')
      card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
      expect(
        patch(:change_confidence_level,
              params: { id: card.id,
                        card: { id: card.id, question: 'test?', answer: 'test', confidence_level: 'very_bad' } })
      ).to have_http_status(:ok)
    end
  end

  describe 'PUT update_card_throw_modal' do
    it 'updates card throw modal window' do
      board = Board.create(user_id: user.id, name: 'test')
      card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
      expect(
        put(:update_card_throw_modal,
            params: { id: card.id,
                      card: { id: card.id, question: 'test2?', answer: 'test2', confidence_level: 'good' } })
      ).to have_http_status(:ok)
    end
  end
end
