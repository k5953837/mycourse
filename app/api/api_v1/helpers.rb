module ApiV1
  module Helpers
    def authenticate!
      current_user or raise AuthorizationError
    end

    def current_user
      @current_user ||= env['api_v1.user']
    end
  end
end
