# frozen_string_literal: true

module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      included do
        rescue_from ::ActiveRecord::RecordNotFound, with: :render_exception_not_found
        rescue_from ::ActiveRecord::RecordInvalid, with: :render_exception_unprocessable_entity

        rescue_from ::Blindbarber::Exceptions::InvalidLogin, with: :render_exception_unauthorized
        rescue_from ::Blindbarber::Exceptions::InvalidAuthToken, with: :render_exception_unauthorized
        rescue_from ::Blindbarber::Exceptions::ExpiredAuthToken, with: :render_exception_unauthorized
        rescue_from ::Blindbarber::Exceptions::UnauthorizedRequest, with: :render_exception_unauthorized

        rescue_from ::Blindbarber::Exceptions::ForbiddenRequest, with: :render_exception_forbidden

        rescue_from ::Blindbarber::Exceptions::PasswordMismatch, with: :render_exception_bad_request

        def render_exception_not_found(exc)
          logger.error(exc)

          render json: { error: 'Entity not found.' }, status: :not_found
        end

        def render_exception_unprocessable_entity(exc)
          logger.error(exc)
          err_messages = exc.record.errors.full_messages

          render json: { error: err_messages }, status: :unprocessable_entity
        end

        def render_exception_unauthorized(exc)
          logger.error(exc)

          render json: { error: exc.message }, status: :unauthorized
        end

        def render_exception_forbidden(exc)
          logger.error(exc)

          render json: { error: exc.message }, status: :forbidden
        end

        def render_exception_bad_request(exc)
          logger.error(exc)

          render json: { error: exc.message }, status: :bad_request
        end
      end
    end
  end
end
