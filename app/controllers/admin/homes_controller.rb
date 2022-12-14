class Admin::HomesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_admin!
  
  def top #管理者トップページ画面(会員一覧)
    #ページネーション、10件表示
    @members = Member.all.page(params[:page]).per(10)
  end
end
