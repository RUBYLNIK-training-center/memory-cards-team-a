require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  before do
    sign_in user
  end

  xdescribe 'PUT update' do
    it 'updates user data' do
      expect(
        put(:update, params: { id: user.id, user: { email: user.email } })
      ).to redirect_to(root_path)
    end
  end
end
