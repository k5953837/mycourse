module Jwt
  class Encoder
    def initialize(user)
      @user = user
    end

    def encode!
      jti = SecureRandom.hex
      @user.update(jti: jti)
      JWT.encode(
        {
          user_id: @user.id,
          jti: jti,
          iat: Time.now.to_i
        },
        secret
      )
    end
  end
end
