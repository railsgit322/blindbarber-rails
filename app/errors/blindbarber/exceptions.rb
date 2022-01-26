# frozen_string_literal: true

module Blindbarber
  module Exceptions
    class InvalidLogin < StandardError
      def initialize(message = 'Invalid email or password.')
        super
      end
    end

    class InvalidAuthToken < StandardError
      def initialize(message = 'Invalid auth token.')
        super
      end
    end

    class ExpiredAuthToken < StandardError
      def initialize(message = 'Expired token.')
        super
      end
    end

    class UnauthorizedRequest < StandardError
      def initialize(message = 'Unauthorized request.')
        super
      end
    end

    class ForbiddenRequest < StandardError
      def initialize(message = 'Forbidden request.')
        super
      end
    end

    class PasswordMismatch < StandardError
      def initialize(message = 'Password and password confirmation must match.')
        super
      end
    end
  end
end
