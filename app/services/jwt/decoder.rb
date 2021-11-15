module Jwt
  class Decoder < Jwt::Base
    def initialize(token)
      @token = token
    end

    def decode!
      decoded = JWT.decode(@token, secret, true, verify_iat: true)[0]
      raise InvalidToken unless decoded.present?

      decoded.symbolize_keys
    end
  end
end
