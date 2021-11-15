module ApiV1
  module Helpers
    def current_user
      request = ::Grape::Request.new(env)
      @current_user ||= ApiV1::Auth::Authenticator.new(request).authenticate!
    end

    def authenticate!
      error!('401 Unauthorized', 401) unless current_user
    end
  end
end
