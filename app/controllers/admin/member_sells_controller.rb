class Admin::MemberSellsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  # before_action :authenticate_admin!

  def index #会員の販売商品一覧画面
    #ページネーション
    @items = Item.all.page(params[:page]).per(10)
  end

  def show #会員の販売商品詳細画面
    @item = Item.find(params[:id])
  end
end
