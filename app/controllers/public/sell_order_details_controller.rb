class Public::SellOrderDetailsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_member!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(sell_order_detail_params)
    # 準備ステータスを全て「商品準備完了」にする→注文ステータスが「発送準備中」に更新される
    #注文ステータス:orderのorder_details(n)の数が準備ステータス:orderのorder_details(n)の商品準備完了した数と同じか判定
    if @order.order_details.count == @order.order_details.where(arranging_status: "prepared").count #商品準備完了
      @order_detail.order.update(order_status: "get_ready") #発送準備中
    end
    redirect_to sell_order_path(@order.id), notice: "ステータスを変更しました" #public/sell_orders#show
  end
  
  private
  def sell_order_detail_params #準備ステータス変更
    params.require(:order_detail).permit(:arranging_status)
  end
end
