module Ikat
  class API
    cattr_accessor :errors

    helpers do

      # Hash of different error types.
      Ikat::API.errors = {
        not_authenticated: {
          code: 401,
          type: 'NotAuthenticated',
          message: 'the client is not authenticated'
        }
      }

      def error!(type, message = nil)
        error = Ikat::API::errors[type.to_sym]

        message ||= error[:message]

        output = {
          error: {
            code: error[:code],
            type: error[:type],
            message: message
          }
        }

        halt error[:code].to_i, Oj.dump(output)
      end
    end
  end
end
