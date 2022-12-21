class Admin::RoomsController < ApplicationController
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
