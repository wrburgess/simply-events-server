module Api
  module V1
    class EventsController < Api::V1::ApiController
      def create
        event = Event.create(create_params)
        render json: event, each_serializer: EventSerializer, status: :created
      end

      def index
        events = Event.all
        render json: events, each_serializer: EventSerializer, status: :ok
      end

      def show
        event = Event.find params[:id]
        render json: event, each_serializer: EventSerializer, status: :ok
      end

      def update
        event = Event.find params[:id]
        event.update_attributes(update_params)
        render json: event, each_serializer: EventSerializer, status: :accepted
      end

      def destroy
        event = Event.find params[:id]
        event.destroy
        render json: {}, status: :accepted
      end

      private

      def update_params
        params.permit(
          :name, :description
        )
      end

      def create_params
        params.permit(
          :name, :description
        )
      end
    end
  end
end
