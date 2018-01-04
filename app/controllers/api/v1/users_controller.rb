module Api

    module V1
        class UsersController < ApiController

            def index
                render json: current_resource_owner.attributes, status: 200
            end

            def create
                user = User.create!(user_params)
                token = Doorkeeper::AccessToken.create!(resource_owner_id: user.id).try(:token)
                render json: {response: user.attributes.merge!(access_token: token), status: 200}
            rescue Exception => e
                render json: {message: e.message}, status: 422
            end


            private

            def user_params
                params.require(:user).permit(:email, :password, :password_confirmation)
            end
        end
    end

end