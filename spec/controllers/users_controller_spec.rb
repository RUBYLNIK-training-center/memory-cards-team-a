require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  before do
    sign_in user
  end

  describe 'GET edit' do
    it 'renders the edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUTCH update_password' do
    context 'with new password' do
      it 'redirect to root path' do
        expect(
          patch(:update_password,
                params: { user: { current_password: user.password, password: '123789',
                                  password_confirmation: '123789' } })
        ).to redirect_to(root_path)
      end
    end

    xcontext 'with old password' do
      it 'render edit' do
        expect(
          patch(:update_password,
                params: { user: { current_password: user.password, password: user.password,
                                  password_confirmation: user.password } })
        ).to redirect_to(root_path)
      end
    end
  end
end
