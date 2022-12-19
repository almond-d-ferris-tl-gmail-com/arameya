class Public::BuyOrdersController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_member!

  def new#注文情報入力
    @order_new = Order.new
    @member = current_member
    @addresses = current_member.addresses
  end

  def comfirm # 注文情報確認#new:注文情報入力→comfirm:注文情報確認→create→complete:注文確定(サンクス)
    #binding.pry#rails sをするとここで処理が一旦止まる→確認のためのコマンドを入力する
    if params[:order][:select_address] == "0"#自身の住所
      @order = Order.new(buy_order_params)
      @order.postal_code = current_member.postal_code
      @order.address = current_member.address
      @order.name = current_member.last_name + current_member.first_name#姓・名

    elsif params[:order][:select_address] == "1"#登録済み住所
      @order = Order.new(buy_order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    elsif params[:order][:select_address] == "2"#新しいお届け先
      @order = Order.new(buy_order_params)
    end
    
    @cart_items = current_member.cart_items#current_member(1):cart_items(多)
    @shipping_cost = 0#送料
    @order.shipping_cost = @shipping_cost
    @total_payment = 0#商品合計
  end

  def complete#注文確定(サンクス)
  end

  def index
    @orders = current_member.orders.all
    #@review = Review.find(params[:review_id])
  end

  def show
    @order = Order.find(params[:id])
    @total_payment = 0
  end
  
  def create#new:注文情報入力→comfirm:注文情報確認→create→complete:注文確定(サンクス)
    cart_items = current_member.cart_items.all
    # ログインユーザーのカートアイテムをすべて取り出してcart_itemsに入れる
    @create_order = current_member.orders.new(buy_order_params)
      # 渡ってきた値を@create_orderに入れる
      if @create_order.save
      # ここに至るまでの間にチェックは済んでいるが、念の為IF文で分岐させる
          cart_items.each do |cart|
          # 取り出したカートアイテムの数分繰り返す
          # order_detailにも一緒にデータを保存する必要があるのでここで保存する
          # 購入が完了したらカート情報は削除するのでこちらに保存する
          # /arameya/db/schema.rbのorder_detailsテーブルと合わせる
          order_detail = OrderDetail.new
          order_detail.item_id = cart.item_id
          order_detail.order_id = @create_order.id
          order_detail.price = cart.item.price#税込 cart.priceだとカートに税込カラムがないといけない→item_idがある→アソシエーションでつなげる
          order_detail.amount = cart.amount#数量
          order_detail.arranging_status = 0#準備ステータス
          # カート情報を削除するので item との紐付けが切れる前に保存する
          order_detail.save
          end
          cart_items.destroy_all#データ削除の遷移先(public/cart_items#destroy_all)
        redirect_to buy_orders_complete_path#public/buy_orders#complete(注文確定(サンクス))
        # ユーザーに関連するカートのデータ(購入したデータ)をすべて削除(カートを空にする)
      else
        @create_order = Order.new(buy_order_params)
        render :new
      end
  end
  
  private
  def buy_order_params#public/buy_orders#show 新しいお届け先(支払方法、郵便番号、住所、名前)
  #permitメソッド:paramsで取得したパラメーターに対し保存の許可を行う
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status)
  end
  
end
