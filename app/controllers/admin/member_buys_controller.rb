class Admin::MemberBuysController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_admin!

  def index #会員の購入履歴一覧画面
    @member = Member.find(params[:member_id])
    #会員本人が購入した商品のみを表示、ページネーション
    @orders = @member.orders.page(params[:page]).per(10)

    # 会員のルームのwhereで指定した管理者IDの配列0番目の要素(first)を取り出す
    # (管理者は現在1名だが、今後複数になる可能性があることを想定してfirstで指定する)
    @room = @member.rooms.where(admin_id: current_admin.id).first # firstの後に.idをつけることができる。それはroom.idのこと
    @review = @member.reviews
    @message = @member.ad_mem_messages
  end

  def show #会員の購入履歴詳細画面
    @member = Member.find(params[:member_id])
    @order = Order.find(params[:id])
    @item = Item.find(params[:id])
    @order_details = @order.order_details
  end
end
