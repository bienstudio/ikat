module Ikat
  class API
    helpers do
      def auth_user
        User.where(access_token: params[:access_token]).first
      end
    end
  end
end
