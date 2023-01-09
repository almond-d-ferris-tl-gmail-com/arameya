class Public::SellOrdersController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_member!

  def index
    #ページネーション
    # orderを取得したい→orderはitem.idを持っていない→item.idを持っているのはorder_detail→orderの子テーブルであるorder.detailをincludesで検索してつなげる→whereで絞り込む
    @orders = Order.includes(:order_details).where(order_details: {item_id: current_member.items.map(&:id)}).page(params[:page]).per(10).order("created_at DESC")
  end

  def show
    # orderが入るとorder_detailsが作られる→order_detailsにはitem_idが存在する(売れた商品のid)→itemはcurrent_member(販売者に紐づいている)→
    # 販売者から見た「自分のitemが買われたorderを知りたい」に対して「自分の持つitemに関係のあるorder_details」を持つ「order」を取得する
    @order = Order.find(params[:id])
    # filter_map・・・{}の中身(今回はif文で条件指定)と合致したものだけ値を返す、購入者が複数の販売者から商品を購入してもif文で自分が販売している商品のみを抽出する
    @order_details = @order.order_details.filter_map { |order_detail| order_detail if current_member.items.map(&:id).include?(order_detail.item_id)}
    # map・・・{}の中身の値をすべて返す(今回は小計subtotal_priceの合計値を返す)
    @total_price = @order_details.map {|order_detail| order_detail.subtotal_price }.sum
    @total_postage = @order_details.map {|order_detail| order_detail.item.postage }.sum
  end
  
  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(sell_order_params)#public/sell_orders#updateのパラメータ
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
    redirect_to sell_order_path(@order.id), notice: "ステータスを変更しました"#public/sell_orders#show
  end
  
  private
  def sell_order_params#public/sell_orders#update 注文ステータス変更、準備ステータス変更
  #permitメソッド:paramsで取得したパラメーターに対し保存の許可を行う
    params.require(:order).permit(:order_status, :arranging_status)
  end
end
