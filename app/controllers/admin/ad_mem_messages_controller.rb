class Admin::AdMemMessagesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_admin!
   before_action :set_member
  
  def create
    # puts params エラーチェック
    if admin_signed_in?
    # binding.irb エラーチェック
    # 管理者→am_mess_speaker: true
      message = AdMemMessage.new(am_mess_body: message_params[:am_mess_body], room_id: message_params[:room_id], am_mess_speaker: true)
    else
      message = AdMemMessage.new(am_mess_body: message_params[:am_mess_body], member_id: @member.id)
    end
    
    if message.save
      redirect_to admin_member_room_path(@member, message.room) # admin/rooms#show
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def message_params
    params.require(:ad_mem_message).permit(:room_id, :am_mess_title, :am_mess_item, :am_mess_body).merge(admin_id: current_admin.id)
  end
  
  def set_member
    @member = Member.find(params[:member_id])
  end
end
