# frozen_string_literal: true

module Auth
  class GenerateRefreshToken
    def initialize(user)
      @user = user
    end

    def call
      refresh_token = SecureRandom.hex(32)
      encrypt_and_save_token(user, refresh_token)

      refresh_token
    end

    private

    attr_reader :user

    def encrypt_and_save_token(user, refresh_token)
      encryption_key = Rails.application.credentials.refresh_token_encryption_key

puts "TOKEN: " + refresh_token

      puts "Key: " + encryption_key
      encrypted_token = OpenSSL::HMAC.hexdigest(
        'sha256', encryption_key, refresh_token
      )

      user.update_attribute(:refresh_token, encrypted_token)
    end
  end
end
