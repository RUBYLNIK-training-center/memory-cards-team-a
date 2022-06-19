require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end
  
  before do
    sign_in user
  end

  describe "GET learn" do
    context 'with cards' do
      it "renders the lern template" do
        board = Board.create(user_id: user.id, name: 'test')
        card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
        get :learn, params: { board_id: board.id }
        expect(response).to render_template('learn/learn')
      end
    end

    context 'without cards' do
      it "redirect to cards path" do
        board = Board.create(user_id: user.id, name: 'test')
        get :learn, params: { board_id: board.id }
        expect(response).to redirect_to(board_cards_path(board))
      end
    end
  end

  describe "GET index" do
    it "returns a successful response" do
      board = Board.create(user_id: user.id, name: 'test')
      get :index, params: { board_id: board.id }
      expect(response).to be_successful
    end
 
    it "assigns @cards" do
      board = Board.create(user_id: user.id, name: 'test')
      card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
      get :index, params: { board_id: board.id }
      expect(assigns(:cards)).to eq([card])
    end

    it "renders the index template" do
      board = Board.create(user_id: user.id, name: 'test')
      get :index, params: { board_id: board.id }
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "renders the show template" do
      board = Board.create(user_id: user.id, name: 'test')
      card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
      get :show, params: { board_id: board.id, id: card.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET new" do
    it "renders the new template" do
      board = Board.create(user_id: user.id, name: 'test')
      get :new, params: { board_id: board.id }
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    context 'with correct params' do
      it "creates new board" do
        board = Board.create(user_id: user.id, name: 'test')
        expect{
          post :create, params: { board_id: board.id, :card => { question: 'test?', answer: 'test', board_id: board.id } }
        }.to change(Card, :count).by(1)
      end
    end

    context 'with incorrect params' do
      it "renders the new template" do
        board = Board.create(user_id: user.id, name: 'test')
        expect(
          post :create, params: { board_id: board.id, :card => { question: nil, answer: 'test', board_id: board.id } }
        ).to render_template(:new)
      end
    end
  end

  describe "DELETE card" do
    it "removes card" do
      board = Board.create(user_id: user.id, name: 'test')
      card = Card.create(question: 'test?', answer: 'test', board_id: board.id)
      expect{
        delete :destroy, params: { board_id: board.id, id: card.id }
      }.to change(Card, :count).by(-1)
    end
  end
end 