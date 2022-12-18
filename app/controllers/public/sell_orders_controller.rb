class Public::SellOrdersController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_member!

  def index
    @member = current_member
    #ページネーション
    @orders = Order.where(member_id: current_member.id).includes(:member).page(params[:page]).per(10)#.order("created_at DESC")
  end

  def show
    @member = current_member
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end
  
  def update
    @member = current_member
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(member_sell_order_params)#public/sell_orders#updateのパラメータ
    # 注文ステータスを「入金待ち」にする→準備ステータスが全て「商品準備不可」に更新される
    if @order.order_status == "waiting"#入金待ち
        @order_details.each do |order_detail|
          order_detail.update(arranging_status: 0)#商品準備不可
        end
    # 注文ステータスを「入金確認済み」にする→準備ステータスが全て「商品準備中」に更新される
    elsif @order.order_status == "confirming"#入金確認済み
        @order_details.each do |order_detail|
          order_detail.update(arranging_status: 1)#商品準備中
        end
    end
    redirect_to member_sell_order_path(@member.id, @order.id), notice: "ステータスを変更しました"#public/sell_orders#show
  end
  
  private
  def member_sell_order_params#public/sell_orders#update 注文ステータス変更、準備ステータス変更
  #permitメソッド:paramsで取得したパラメーターに対し保存の許可を行う
    params.require(:order).permit(:order_status)
  end

end
