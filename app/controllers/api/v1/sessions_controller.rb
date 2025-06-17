# sessions_controller.rb
module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :authenticate_user!, only: [:create], raise: false
      respond_to :json

      # 👇 Override to fetch params properly from JSON
      def create
        user = User.find_by(email: params[:user][:email])

        if user && user.valid_password?(params[:password] || params.dig(:user, :password))
          sign_in(user)
          render json: {
            message: 'Logged in.',
            user: {
              id: user.id,
              email: user.email,
              created_at: user.created_at,
              updated_at: user.updated_at
            }
          }, status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def respond_to_on_destroy
        head :no_content
      end
    end
  end
end
