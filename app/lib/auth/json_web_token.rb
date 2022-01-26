# frozen_string_literal: true

class Auth::JsonWebToken
  class << self
    EXPIRATION = Time.now.to_i + (3600 * 24 * 30)
    TOKEN_SECRET = Rails.application.credentials.secret_key_base

    def encode(payload, exp = EXPIRATION)
      payload[:exp] = exp.to_i

      JWT.encode(payload, TOKEN_SECRET)
    end

    def decode(token)
      body = JWT.decode(token, TOKEN_SECRET)[0]

      HashWithIndifferentAccess.new body
    rescue JWT::ExpiredSignature => e
      # raise ::Pickup::Exceptions::ExpiredAuthToken

      # TODO: remove this and reject expired tokens until
      # iOS has fixed their bug to deal with expired tokens!
      # right now, app is crashing when tokens expire
      body = JWT.decode(token, TOKEN_SECRET, false)[0]
      HashWithIndifferentAccess.new body
    end
  end
end
