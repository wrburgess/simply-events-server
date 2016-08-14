module Api
  module V1
    class SessionsController < Api::V1::ApiController
      skip_before_action :authenticate

      def create
        user = User.find_by(email: auth_params[:email])
        if user && user.authenticate(auth_params[:password])
          jwt = Auth.issue(user: user.id)
          render json: { jwt: jwt }, status: :created
        else
          render json: { error: :forbidden }, status: :forbidden
        end
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end
