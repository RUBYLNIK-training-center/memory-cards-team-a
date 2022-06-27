require 'rails_helper'
include ControllerHelpers

RSpec.describe BoardsController, type: :controller do
  let(:user) {validUser}

  before do
    sign_in user
  end

  describe 'GET index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns @imports' do
      board = Board.create(user_id: user.id, name: 'test')
      get :index
      expect(assigns(:boards)).to eq([board])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET show' do
    it 'renders the show template' do
      board = Board.create(user_id: user.id, name: 'test')
      get :show, params: { id: board.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'renders the edit template' do
      board = Board.create(user_id: user.id, name: 'test')
      get :edit, params: { id: board.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST create' do
    context 'with valid structure of csv' do
      it 'creates new board' do
        expect do
          post :create, params: { board: { user_id: user.id, name: 'test' } }
        end.to change(Board, :count).by(1)
      end
    end

    context 'with incorrect params' do
      it 'renders the new template' do
        expect(
          post(:create, params: { board: { user_id: user.id, name: nil } })
        ).to render_template(:new)
      end
    end
  end

  describe 'PUTCH update' do
    it 'updates board' do
      board = Board.create(user_id: user.id, name: 'test')
      expect(
        patch(:update, params: { id: board.id, board: { user_id: user.id, name: 'test2' } })
      ).to redirect_to action: :show, id: assigns(:board).id
    end

    context 'with incorrect params' do
      it 'renders the edit template' do
        board = Board.create(user_id: user.id, name: 'test')
        expect(
          patch(:update, params: { id: board.id, board: { user_id: user.id, name: nil } })
        ).to render_template(:edit)
      end
    end
  end

  describe 'DELETE board' do
    it 'removes board' do
      board = Board.create(user_id: user.id, name: 'test')
      expect  do
        delete :destroy, params: { id: board.id }
      end.to change(Board, :count).by(-1)
    end
  end
end
