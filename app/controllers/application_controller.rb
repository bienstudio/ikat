class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(
        :email,
        :name,
        :username,
        :password,
        :password_confirmation
      )
    end

    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(
        :email,
        :name,
        :username,
        :biography,
        :location,
        :website,
        :current_password,
        :password,
        :password_confirmation,
        :avatar
      )
    end
  end
end
