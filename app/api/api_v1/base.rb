module ApiV1
  class Base < Grape::API
    version 'v1', using: :path

    # Includes
    include ApiV1::ExceptionHandlers
    # Helpers
    helpers ::ApiV1::Helpers
    # Mounts
    mount Login
    mount Ping
    mount PurchaseCourse
  end
end
