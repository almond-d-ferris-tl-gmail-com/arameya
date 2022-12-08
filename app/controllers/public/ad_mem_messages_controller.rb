class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!
  # before_action :set_room_or_move, only: :show

  def create
    message = AdMemMessage.new(message_params)
    if message.save
      redirect_to room_path(room_id) # public/rooms#show message.room.reservation_id
    else
      redirect_to room_path(room_id), alert: 'メッセージを送信できませんでした'
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id).merge(member_id: current_member.id)
  end
end