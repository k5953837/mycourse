module ApiV1
  module Entities
    class User < Entities::Base
      expose :email
      expose :token do |user, options|
        Jwt::Encoder.new(user).encode!
      end
      expose :updated_at, format_with: :iso8601
    end
  end
end
