module ApiV1
  module Auth
    class Middleware < Grape::Middleware::Base
      def before
        # Authenticate the authorization token
        request = ::Grape::Request.new(env)
        current_user, decoded_token = Authenticator.new(request).authenticate!

        # Assign current_user and decoded_token to env
        @env['api_v1.current_user'] = current_user
        @env['api_v1.decoded_token'] = decoded_token
      end
    end
  end
end
