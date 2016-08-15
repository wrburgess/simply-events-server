module Api
  module V1
    class FavoritesController < Api::V1::ApiController
      def create
        favorite = Favorite.create(create_params)
        render json: favorite, each_serializer: FavoriteSerializer, status: :created
      end

      def index
        favorites = Favorite.all
        render json: favorites, each_serializer: FavoriteSerializer, status: :ok
      end

      def show
        favorite = Favorite.find params[:id]
        render json: favorite, each_serializer: FavoriteSerializer, status: :ok
      end

      def destroy
        favorite = Favorite.find(params[:id])
        favorite.destroy
        render json: {}, status: :accepted
      end

      private

      def create_params
        params.permit(
          :event_id, :user_id
        )
      end
    end
  end
end
