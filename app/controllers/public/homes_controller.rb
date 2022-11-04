class Public::HomesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→topボタンを押したらtopに遷移する
  #before_action :authenticate_customer!, except: [:top]#customer→テーブル名

  def top
    @items = Item.where(is_active:true).order('id DESC').limit(4)
    #where→()内の条件が合っていればデータを持ってくる、今回は販売中の商品(is_active:true)のみデータを表示させる
    #DESC→降順に並び替える、limit(4)→新着４件を取り出す
  end

  def about
  end
end
