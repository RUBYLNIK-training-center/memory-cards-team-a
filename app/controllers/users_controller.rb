class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def edit
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def update_account_type
    @user = current_user
    respond_to do |format|
      if ActivatePremiumAccount.new(user: @user).call
        format.html { redirect_to root_path, notice: 'User was upgraded to Premium plan.', status: 200 }
      end
    end
  end

  private

  def user_params
    # NOTE: Using `strong_parameters` gem
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
