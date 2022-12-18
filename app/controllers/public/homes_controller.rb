class Public::HomesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→topボタンを押したらtopに遷移する
  #before_action :authenticate_customer!, except: [:top]#customer→テーブル名

  def top
    @items = Item.where(sell_status:0).order('id DESC').limit(8)
    #where→()内の条件が合っていればデータを持ってくる、今回は販売中の商品(sell_status:0)のみデータを表示させる
    #DESC→降順に並び替える、limit(8)→新着8件を取り出す
  end

  def about
  end
end
