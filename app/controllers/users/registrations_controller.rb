# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    #新規登録時に、登録ずみ電話番号を表示する際、使用
    @use_current_password = User.pluck(:src)

    # 先頭の文字列が「0」で始まったら、そのまま返却させる
    # [reason] : to_i を行うと、0044 等が 0 になるので
    @use_current_password.map!{|x|
      if x.start_with?("0") 
        x
      else
        x.to_i
      end
    }

    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # 新規登録時に、ビューから受け取りたい値を記入する。
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:src,:telephone_pass])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # サインアップ後に、flashメッセージを表示
  def after_sign_up_path_for(resource)
    flash[:sip_regist_success] = "電話サービスを使うことが出来ます。🎶"
    user_path(resource)
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
