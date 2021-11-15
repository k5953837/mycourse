module ApiV1
  module Entities
    class Order < Entities::Base
      expose :category
      expose :expired_at, format_with: :iso8601
      expose :snapshot
      expose :subject
      expose :updated_at, format_with: :iso8601
    end
  end
end
