# frozen_string_literal: true

class Api::BaseController < ActionController::API
  #include Pagy::Backend
  include ::Api::V1::ErrorHandler

  before_action :authorize_request

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = Auth::AuthorizeApiRequest.new(
      request.headers
    ).call
  end
end
