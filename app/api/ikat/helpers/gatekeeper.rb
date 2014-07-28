module Ikat
  class API
    helpers do
      def auth_user
        User.where(access_token: params[:access_token]).first
      end

      def authorize!
        if auth_user.nil?
          error!(:not_authenticated)
        end
      end
    end
  end
end
