# frozen_string_literal: true

module Auth
  class AuthenticateUser
    def initialize(email, password)
      @email = email
      @password = password
    end

    def call
      Auth::JsonWebToken.encode(user_id: user.id) if user
    end

    private

    attr_reader :email, :password

    def user
      user = User.find_by_email(email)
      return user if user&.authenticate(password)

      raise ::Pickup::Exceptions::InvalidLogin
    end
  end
end
