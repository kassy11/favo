class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 新規登録後のリダイレクト先をマイページへ
    def after_sign_in_path_for(resource)
        root_path
    end

  # サインイン後のリダイレクト先をマイページへ
    def after_sign_in_path_for(resource)
        root_path
    end

    # サインアウト後のリダイレクト先をトップページへ
    def after_sign_out_path_for(resource)
        root_path
    end

    # deviseコントローラーにストロングパラメータを追加する
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    # アカウント編集の時にnameとprofileのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end
end
