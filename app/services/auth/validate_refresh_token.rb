# frozen_string_literal: true

module Auth
  class ValidateRefreshToken
    def initialize(refresh_token)
      @refresh_token = refresh_token
    end

    def call
      encrypted_token = encrypt_token(refresh_token)
      user = User.find_by_refresh_token(encrypted_token)

      raise ::Blindbarber::Exceptions::InvalidAuthToken unless user

      user
    end

    private

    attr_reader :refresh_token

    def encrypt_token(token)
      encryption_key =
        Rails.application.credentials.refresh_token_encryption_key

      OpenSSL::HMAC.hexdigest('sha256', encryption_key, token)
    end
  end
end
