module Ikat
  class API
    helpers do
      def auth_user
        User.where(access_token: params[:access_token]).first
      end

      def authorize!
        return error!(:not_authenticated) if auth_user.nil?
      end
    end
  end
end
