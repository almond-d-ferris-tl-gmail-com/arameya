class ApplicationController < ActionController::Base
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→topボタンを押したらtopに遷移する
  #before_action :authenticate_customer!, except: [:top]#customer→テーブル名

  #CSRF対策(クロスサイトリクエストフォージェリ)
    protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

    protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
