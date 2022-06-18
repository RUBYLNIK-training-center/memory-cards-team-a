require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  before do
    sign_in user
  end

  describe "GET edit" do
    it "renders the edit template" do
      get :edit, params: { id: user.id }
      expect(response).to render_template(:edit)
    end
  end
end