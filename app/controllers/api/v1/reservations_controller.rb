module Api
  module V1
    class ReservationsController < ApplicationController
      def create
        response = ReservationCreator.call(reservation_params)
        status = response.delete(:status)
        render json: response, status: status
      end

      private
      def reservation_params
        path_params = request.path_parameters
        params.except(*path_params.keys)
      end
    end
  end
end
