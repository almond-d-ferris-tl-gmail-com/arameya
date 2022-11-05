# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :member_state, only: [:create]

protected
  # 退会しているかを判断するメソッド、退会後は同じアカウントで利用できない
  def member_state
    # 【処理内容1】 入力されたemailからアカウントを1件取得
    @member = Member.find_by(email: params[:member][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@member
    # 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    if @member.valid_password?(params[:member][:password])
    # 【処理内容3】 「1」と「2」の処理が真(true)+そのアカウントのis_deletedカラムに格納されている値が
    #   trueなら退会済→サインアップ画面に遷移、falseなら未退会→そのままcreateアクションを実行
      if (@member.is_deleted == true)
        #public/registrations#new(顧客ログイン画面)
        redirect_to new_member_registration_path, notice:"退会済みのアカウントです。新規登録をしてください。"
      end
    end
  end

  #ログイン後に表示する画面
  def after_sign_in_path_for(resource)
      top_path#public/homes#top
  end

  #ログアウト後に表示する画面
  def after_sign_out_path_for(resource)
      top_path#public/homes#top
  end

  # before_action :configure_sign_in_params, only: [:create]

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
