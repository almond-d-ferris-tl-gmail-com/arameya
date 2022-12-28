class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    #byebug
    @member = Member.find(params[:member_id])    

    # puts params エラーチェック
    if member_signed_in?
    # binding.irb エラーチェック
    # 会員→am_mess_speaker: false
      message = AdMemMessage.new(room_id: message_params[:room_id], am_mess_title: message_params[:am_mess_title], am_mess_item: message_params[:am_mess_item], am_mess_body: message_params[:am_mess_body], am_mess_speaker: false)
    else
      message = AdMemMessage.new(admin_id: admin.id, am_mess_title: message_params[:am_mess_title], am_mess_item: message_params[:am_mess_item], am_mess_body: message_params[:am_mess_body])
    end
    
    if message.save!
      redirect_to member_room_path(@member.id, message.room)# public/rooms#show
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:ad_mem_message).permit(:room_id, :am_mess_title, :am_mess_item, :am_mess_body).merge(member_id: current_member.id)
  end
end
