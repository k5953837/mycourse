module ApiV1
  module ExceptionHandlers
    def self.included(base)
      base.instance_eval do
        rescue_from Grape::Exceptions::ValidationErrors do |e|
          rack_response({
            error: {
              code: e.status,
              message: e.message
            }
          }.to_json, e.status)
        end

        rescue_from ActiveRecord::RecordNotFound do
          rack_response({ 'message' => '404 Not found' }.to_json, 404)
        end

        route :any, '*path' do
          error!('404 Not Found', 404)
        end
      end
    end
  end

  class Error < Grape::Exceptions::Base
    attr :code, :text

    def initialize(opts = {})
      @code    = opts[:code]   || 2000
      @text    = opts[:text]   || ''

      @status  = opts[:status] || 400
      @message = { error: { code: @code, message: @text } }
    end
  end

  class AuthorizationError < Error
    def initialize
      super code: 2001, text: 'Authorization Failed', status: 401
    end
  end

  class MissingJwtToken < Error
    def initialize
      super code: 2002, text: 'Missing JWT Token', status: 403
    end
  end

  class InvalidToken < Error
    def initialize
      super code: 2003, text: 'Invalid Token', status: 403
    end
  end

  class OfflineCourse < Error
    def initialize
      super code: 2004, text: 'Offline Course', status: 403
    end
  end

  class ExistAvailableCourse < Error
    def initialize
      super code: 2005, text: 'Exist Available Course', status: 403
    end
  end
end
