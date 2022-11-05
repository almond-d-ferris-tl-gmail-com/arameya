# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  #ログイン後に表示する画面
  def after_sign_in_path_for(resource)
      admin_homes_top_path#admin/homes#top
  end

  #ログアウト後に表示する画面
  def after_sign_out_path_for(resource)
      new_admin_session_path#admin/sessions#new
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
