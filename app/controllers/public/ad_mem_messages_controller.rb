class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    # puts params
    ad_mem_message_params =  params["ad_mem_message"]
    # puts ad_mem_message_params
    # puts ad_mem_message_params["room_id"]
    # puts ad_mem_message_params["am_mess_body"]
    # byebug
    if member_signed_in?
      message = AdMemMessage.new(am_mess_body: ad_mem_message_params["am_mess_body"], room_id: ad_mem_message_params["room_id"])
    else
      message = AdMemMessage.new(am_mess_body: ad_mem_message_params["am_mess_body"], admin_id: current_admin.id)
    end
    
    if message.save!
      redirect_to room_path(message.room)# public/rooms#show
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:ad_mem_message).permit(:room_id, :am_mess_title, :am_mess_item, :am_mess_body).merge(member_id: current_member.id)
  end
end
