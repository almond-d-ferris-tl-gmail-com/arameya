class Admin::RoomsController < ApplicationController
  def show
    @member = Member.find(params[:id])
    
    #フォームに渡すために、モデルのインスタンスを作成
    @message = AdMemMessage.new
    #受け取ったパラメータでルームオブジェクトを取得
    @room = Room.find(params[:id])
    #ルーム内のメッセージを全て表示する
    @messages = @room.ad_mem_messages
    #会員(メッセージ相手)メッセージの取得
    # /arameya/app/models/ad_mem_message.rbにてメッセージ発言者:false(会員)を設定
    @mem_mess = @messages.member_message
  end
end
