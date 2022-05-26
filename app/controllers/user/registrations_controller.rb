# frozen_string_literal: true

# module User
  class RegistrationsController < Devise::RegistrationsController
    # before_action :configure_sign_up_params, only: [:create]
    before_action :configure_account_update_params, only: [:update]
    # before_action :configure_account_update_params, only: [ :update]

    protected

    def update_resource(resource, params)
      # Require current password if user is trying to change password.
      return super if params["password"]&.present?

      # Allows user to update registration information without password.
      resource.update_without_password(params.except("current_password"))
    end




    # # //add to(Mandatory)
    # def update_resource(resource, params)
    #   if params[:current_password].blank?
    #     resource.update_without_password(params.except(:current_password))
    #   else
    #     resource.update_with_password(params)
    #   end
    # end
  end
# end
