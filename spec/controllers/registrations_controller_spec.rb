require 'rails_helper'
include ControllerHelpers

RSpec.describe RegistrationsController, type: :controller do
  let(:user) {validUser}

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
