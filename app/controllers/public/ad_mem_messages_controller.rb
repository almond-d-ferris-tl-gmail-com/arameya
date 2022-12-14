class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    # puts params エラーチェック
    if member_signed_in?
    # binding.irb エラーチェック
    # 会員→am_mess_speaker: false
      message = AdMemMessage.new(am_mess_body: message_params[:am_mess_body], room_id: message_params[:room_id], am_mess_speaker: false)
    else
      message = AdMemMessage.new(am_mess_body: message_params[:am_mess_body], admin_id: admin.id)
    end
    
    if message.save!
      redirect_to room_path(admin, message.room)# public/rooms#show
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:ad_mem_message).permit(:room_id, :am_mess_title, :am_mess_item, :am_mess_body).merge(member_id: current_member.id)
  end
end
