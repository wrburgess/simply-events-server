module Api
  module V1
    class UsersController < Api::V1::ApiController
      def create
        user = User.create(create_params)
        render json: user, each_serializer: UserSerializer, status: :created
      end

      def index
        users = User.all
        render json: users, each_serializer: UserSerializer, status: :ok
      end

      def show
        user = User.find params[:id]
        render json: user, each_serializer: UserSerializer, status: :ok
      end

      def update
        user = User.find params[:id]
        user.update_attributes(update_params)
        render json: user, each_serializer: UserSerializer, status: :accepted
      end

      def destroy
        user = User.find params[:id]
        user.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :email, :first_name, :last_name, :password, :password_confirmation
        )
      end

      def create_params
        params.permit(
          :email, :first_name, :last_name, :password, :password_confirmation
        )
      end
    end
  end
end
