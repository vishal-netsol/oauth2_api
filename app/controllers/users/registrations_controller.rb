class Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    respond_to :html, only: []
    respond_to :xml, only: []
  
    # skip_before_action :verify_authenticity_token
  
    before_action :not_allowed, only: [:new, :edit, :cancel]
  
    def not_allowed
      raise MethodNotAllowed
    end
  
    def create
        User.create!(sign_up_params)
        render json: {response: "User Created", status: 200}
    rescue Exception => e
        render json: {message: e.message}, status: 422
    end

    private
  
    def sign_up_params
      params.require(:user).permit([
        :email,
        :password,
        :password_confirmation,
        :full_name
      ])
    end
  
    def account_update_params
      params.require(:user).permit([
        :email,
        :full_name
      ])
    end
end