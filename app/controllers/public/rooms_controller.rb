class Public::RoomsController < ApplicationController
before_action :authenticate_member!

  def create
    room = Room.create
    current_entry = Entry.create(member_id: current_member.id, room_id: room.id)
    another_entry = Entry.create(member_id: params[:entry][:member_id], room_id: room.id)
    redirect_to room_path(room)
  end

  def index
    # ログインユーザー所属ルームID取得
    current_entries = current_member.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # 自分のroom_idでmember_idが自分じゃないのを取得
    @another_entries = Entry.where(room_id: my_room_id).where.not(member_id: current_member.id)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(member_id: current_member.id).first
  end
end