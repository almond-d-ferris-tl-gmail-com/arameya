class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    if member_signed_in?
      message = Message.new(content: message_params[:content], member_id: current_member.id)
    else
      message = Message.new(content: message_params[:content], admin_id: current_admin.id)
    end
    
    if message.save
      redirect_to room_path(message.room)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id).merge(member_id: current_member.id)
  end
end

###########

  def create
    #フォームから受け取った値でチャットルームオブジェクトを取得
    @chat_room=ChatRoom.find(params[:chat_message][:chat_room_id])
    #フォームから受け取った値で、チャットメッセージオブジェクトを作成
    @chat_message=ChatMessage.new(user_id: current_user.id, chat_room_id: @chat_room.id, content: params[:chat_message][:content])
    #保存に成功したら、フラッシュメッセージを表示し、チャットルームへリダイレクトする。
    if @chat_message.save
      flash[:notice]="メッセージの送信に成功しました。"
      redirect_to chat_room_path(@chat_room)
    #保存に失敗した場合は、フラッシュメッセージ表示し、チャットルームへリダイレクトする。
    else
      flash[:alert]="メッセージの送信に失敗しました。"
      redirect_to chat_room_path(@chat_room)
    end
  end