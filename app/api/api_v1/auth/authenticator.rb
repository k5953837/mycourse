module ApiV1
  module Auth
    class Authenticator
      def initialize(request)
        @request = request
      end

      def authenticate!
        # Authenticate authorization token
        token = authenticate_header(@request.headers)
        raise MissingJwtToken unless token.present?

        # Decoded the token and find current_user
        decoded_token = Jwt::Decoder.new(token).decode!
        user = authenticate_user(decoded_token)

        # Return current_user and decoded token
        [user, decoded_token]
      end

      private

      def authenticate_header(headers)
        headers['Authorization']&.split('Bearer ')&.last
      end

      def authenticate_user(decoded_token)
        # Check jti and user_id exist?
        raise InvalidToken unless decoded_token[:jti].present? && decoded_token[:user_id].present?

        # Validate user and jti
        user = User.find(decoded_token.fetch(:user_id))
        raise AuthorizationError unless valid_jti?(user, decoded_token)

        user
      end

      def valid_jti?(user, decoded_token)
        user.jti == decoded_token.fetch(:jti)
      end
    end
  end
end
