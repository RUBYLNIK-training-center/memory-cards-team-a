class OmniauthController < Devise::OmniauthCallbacksController
  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    else
      flash[:error] = t('controller.omniauth_controllers.error_github')
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    else
      flash[:error] = t('controller.omniauth_controllers.error_google')
      redirect_to new_user_registration_url
    end
  end

  def failure
    flash[:error] = t('controller.omniauth_controllers.error_failure')
    redirect_to new_user_registration_url
  end
end
