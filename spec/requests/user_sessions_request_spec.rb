require 'spec_helper'

describe "GET ../callback'" do
  describe "GET 'users/auth/google_oauth2/callback'" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                           provider: 'google_oauth2',
                                                                           uid: '123545',
                                                                           info: {
                                                                             first_name: 'Gaius',
                                                                             last_name: 'Baltar',
                                                                             email: 'test@example.com'
                                                                           },
                                                                           credentials: {
                                                                             token: '123456',
                                                                             expires_at: Time.now + 1.week
                                                                           },
                                                                           extra: {
                                                                             raw_info: {
                                                                               gender: 'male'
                                                                             }
                                                                           }
                                                                         })
      get '/users/auth/google_oauth2/callback'
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
    end

    # it "should set user_id" do
    #   expect(session[:user_id]).to eq(User.last.id)
    # end

    it 'redirects to root' do
      expect(response).to redirect_to root_path
    end
  end

  # describe "GET '/auth/failure'" do
  #
  #   it "should redirect to root" do
  #       get "/auth/failure"
  #     expect(response).to redirect_to root_path
  #   end
  # end

  describe "GET 'users/auth/github/callback'" do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
                                                                    provider: 'github',
                                                                    uid: '123545',
                                                                    info: {
                                                                      first_name: 'Gaius',
                                                                      last_name: 'Baltar',
                                                                      email: 'test@example.com'
                                                                    },
                                                                    credentials: {
                                                                      token: '123456',
                                                                      expires_at: Time.now + 1.week
                                                                    },
                                                                    extra: {
                                                                      raw_info: {
                                                                        gender: 'male'
                                                                      }
                                                                    }
                                                                  })
      get '/users/auth/github/callback'
      request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:github]
    end

    # it "should set user_id" do
    #   expect(session[:user_id]).to eq(User.last.id)
    # end

    it 'redirects to root' do
      expect(response).to redirect_to root_path
    end
  end
end
