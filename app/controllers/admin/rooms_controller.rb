class Admin::RoomsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_admin!
  
  def show
    @member = Member.find(params[:member_id])
    
    #フォームに渡すために、モデルのインスタンスを作成
    @message = AdMemMessage.new
    #受け取ったパラメータでルームオブジェクトを取得
    @room = Room.find(params[:id])
    #ルーム内のメッセージを全て表示して降順(最新が上)にする
    @messages = @room.ad_mem_messages.order(created_at: :desc)
  end
end
