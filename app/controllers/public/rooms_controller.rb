class Public::RoomsController < ApplicationController
before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
      
    #フォームに渡すために、モデルのインスタンスを作成
    @message = AdMemMessage.new
    #受け取ったパラメータでルームオブジェクトを取得
    @room = Room.find(params[:id])
    #ルーム内のメッセージを全て表示する
    @messages = @room.ad_mem_messages
    #管理者(メッセージ相手)メッセージの取得
    # /arameya/app/models/ad_mem_message.rbにてメッセージ発言者:true(管理者)を設定
    @ad_mess = @messages.admin_message
  end

  def create
    # 自身(会員)のroomがあるか判定
     @room = Room.where(member_id: current_member.id, room_id: room.id)
    # roomが存在しない場合、新規作成する
     if @room.nil?
       @room = Room.new(params[:id])
     end
     redirect_to rooms_path(room)# public/rooms#show
  end

end