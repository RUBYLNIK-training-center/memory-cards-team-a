module ControllerHelpers
  def sign_in(user = instance_doubles('user'))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end

  def validUser
    user = User.new(email: 'test10@example.com', name: 'Test', surname: 'Tester', password: '123456',
      password_confirmation: '123456' )
    if User.exists?(email: user.email)
      user = User.where(email: user.email)[0]
    else
      user.skip_confirmation!
      user.save!
    end
    user
  end
end
