module Jwt
  class Base
    private

    def secret
      Rails.application.secrets.secret_key_base
    end
  end
end
