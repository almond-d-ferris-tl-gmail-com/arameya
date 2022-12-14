class Public::RoomsController < ApplicationController
before_action :authenticate_member!

  def show
    @member = Member.find(params[:id])
      
    #フォームに渡すために、モデルのインスタンスを作成
    @message = AdMemMessage.new
    #受け取ったパラメータでルームオブジェクトを取得
    @room = Room.find(params[:id])
    #ルーム内のメッセージを全て表示して降順(最新が上)にする
    @messages = @room.ad_mem_messages.order(created_at: :desc)
  end

  def create
    # 自身(会員)のroomがあるか判定
     @room = Room.where(member_id: current_member.id, room_id: room.id)
    # roomが存在しない場合、新規作成する
     if @room.nil?
       @room = Room.new(params[:id])
     end
     redirect_to room_path(room)# public/rooms#show
  end

end