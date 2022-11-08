class Admin::MemberBuysController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  # before_action :authenticate_admin!

  def index #会員の購入履歴一覧画面
    #ページネーション
    @items = Item.all.page(params[:page]).per(10)
  end

  def show #会員の購入履歴詳細画面
    @order = Order.find(params[:id])
    @item = Item.find(params[:id])
    @order_details = @order.order_details
  end
end
