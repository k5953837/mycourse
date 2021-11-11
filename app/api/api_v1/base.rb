module ApiV1
  class Base < Grape::API
    version 'v1', using: :path

    # Includes
    include ApiV1::ExceptionHandlers
    # Uses
    use ApiV1::Auth::Middleware
    # Helpers
    helpers ::ApiV1::Helpers
    # Mounts
    mount Ping
  end
end
