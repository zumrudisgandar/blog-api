module Api
  module V1
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      # skip_before_action :verify_authenticity_token
      before_action :ensure_params_exist
      # protect_from_forgery with: :null_session

      def create
        build_resource(sign_up_params)

        if resource.save
          render json: { message: 'User registered successfully', user: resource }, status: :ok
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def respond_with(resource, _opts = {})
        if resource.persisted?
          render json: {message: 'User registered successfully', user: resource}, status: ok
        else
          render json: {errors: resource.errors.full_messages}, status: :unprocessable_entity
        end
      end

      def respond_to_on_destroy
        head :no_content
      end

      def ensure_params_exist
        return if params[:user].present?

        render json: { error: 'Missing user parameter' }, status: :bad_request
      end

      def sign_up_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

    end
  end
end