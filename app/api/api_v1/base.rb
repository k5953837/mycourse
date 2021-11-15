module ApiV1
  class Base < Grape::API
    version 'v1', using: :path

    # Includes
    include ApiV1::ExceptionHandlers
    # Helpers
    helpers ::ApiV1::Helpers
    # Mounts
    mount Login
    mount OrderList
    mount Ping
    mount PurchaseCourse

    # Swagger documentation
    add_swagger_documentation(
      mount_path: 'swagger_doc',
      hide_format: true,
      hide_documentation_path: true
    )
  end
end
