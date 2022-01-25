# frozen_string_literal: true

module Auth
  class AuthorizeApiRequest
    def initialize(headers = {})
      @headers = headers
    end

    def call
      user
    end

    private

    attr_reader :headers

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    rescue ActiveRecord::RecordNotFound => e
      raise ::Pickup::Exceptions::InvalidAuthToken
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      if headers['Authorization'].present?
        return headers['Authorization'].split(' ').last
      end

      raise ::Pickup::Exceptions::UnauthorizedRequest
    end
  end
end
