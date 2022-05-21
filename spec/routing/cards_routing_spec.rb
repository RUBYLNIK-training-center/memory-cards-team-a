require 'rails_helper'

RSpec.describe CardsController, type: :routing do
  let(:board) do
    Board.create(name: 'Anything', user_id: user.id)
  end

  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  let(:card) do
    Card.create(question: 'Is it test?', answer: 'yep', board_id: board.id)
  end

  describe 'routing' do
    it 'routes to #index' do
      expect(get: "/boards/#{board.id}/cards").to route_to('cards#index', board_id: board.id.to_s)
    end

    it 'routes to #learn' do
      expect(get: "/boards/#{board.id}/learning").to route_to('cards#learn', board_id: board.id.to_s)
    end

    it 'routes to #new' do
      expect(get: "/boards/#{board.id}/cards/new").to route_to('cards#new', board_id: board.id.to_s)
    end

    it 'routes to #show' do
      expect(get: "/boards/#{board.id}/cards/#{card.id}").to route_to('cards#show', board_id: board.id.to_s,
                                                                                    id: card.id.to_s)
    end

    it 'routes to #edit' do
      expect(get: "/boards/#{board.id}/cards/#{card.id}/edit").to route_to('cards#edit', board_id: board.id.to_s,
                                                                                         id: card.id.to_s)
    end

    it 'routes to #create' do
      expect(post: "/boards/#{board.id}/cards").to route_to('cards#create', board_id: board.id.to_s)
    end

    it 'routes to #update via PUT' do
      expect(put: "/boards/#{board.id}/cards/#{card.id}").to route_to('cards#update', board_id: board.id.to_s,
                                                                                      id: card.id.to_s)
    end

    it 'routes to #update via PATCH' do
      expect(patch: "/boards/#{board.id}/cards/#{card.id}").to route_to('cards#update', board_id: board.id.to_s,
                                                                                        id: card.id.to_s)
    end

    it 'routes to #destroy' do
      expect(delete: "/boards/#{board.id}/cards/#{card.id}").to route_to('cards#destroy', board_id: board.id.to_s,
                                                                                          id: card.id.to_s)
    end
  end
end
