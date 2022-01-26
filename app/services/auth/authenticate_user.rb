# frozen_string_literal: true

module Auth
  class AuthenticateUser
    def initialize(email, password)
      puts "AuthenticateUser USER: " + email
      puts "AuthenticateUser PASS: " + password
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
      puts "email: " + email + " p: '" + password + "' " + user.inspect
      return user if user&.authenticate(password)

      raise ::Blindbarber::Exceptions::InvalidLogin
    end
  end
end
