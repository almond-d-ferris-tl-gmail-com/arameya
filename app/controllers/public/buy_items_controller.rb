class Public::BuyItemsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→indexボタンを押したらindexに遷移する
  before_action :authenticate_customer!, except: [:index]#customer→テーブル名

  def index#商品一覧
    #サイドバー
    @genres = Genre.all
    #商品一覧　idを新着順に並び替える
    @items = Item.where(is_active:true).order('id DESC').page(params[:page]).per(8)
    #where→()内の条件が合っていればデータを持ってくる、今回は販売中の商品(is_active:true)のみデータを表示させる
    #DESC→降順に並び替える、per(8)→8件表示
    #商品の最大値を取得
    @items_max = Item.maximum(:id)
  end

  def show
    @show_public_item = Item.find(params[:id])
    @cart_item = CartItem.new#新規注文
  end
end
