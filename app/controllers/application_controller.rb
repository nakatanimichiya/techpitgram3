class ApplicationController < ActionController::Base


  # nameカラムを保存できるようにする
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    # ストロングパラメータ（指定していないパラメーターを受け取らない）
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end

end
