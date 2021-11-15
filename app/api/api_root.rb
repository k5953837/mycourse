class ApiRoot < Grape::API
  PREFIX = '/api'.freeze

  format :json

  mount ApiV1::Base
end
