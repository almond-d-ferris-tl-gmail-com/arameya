class Public::AdMemMessagesController < ApplicationController
  before_action :authenticate_member!
  # before_action :set_room_or_move, only: :show

  def new #レビュー・評価新規作成
    @mess_new = AdMemMessage.new
  end
  
  def index
    # 会員の情報を取得
    @member = Member.find(params[:member_id])
    # 会員が投稿したレビューの情報を取得
    @messages = @member.messages
  end

  def show
    if current_member.id.to_i == params[:member_id].to_i
      @admin_id = params[:admin_id]
      @messages = Message.where(member_id: params[:member_id],admin_id: @admin_id).or(Message.where(member_id: params[:admin_id],admin_id: params[:member_id])).order(created_at: :asc)
      unread_messages = Message.where(admin_opentime: nil,admin_id: current_member.id)
      unread_messages.each do |unread_message|
        unread_message.admin_opentime = Date.today.to_time
        unread_message.save
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
    # @message = AdMemMessage.find(params[:id])
    # move_to_index_for_expired
    # @message = Message.new
    # @messages = Message.where(room_id: @room.id)
  end

  def create
    #newで新規登録後、一覧(index)に遷移する
    @review_new = Review.new(review_params)#updateのパラメータ
    @review_new.member_id = current_member.id
    #byebug
     #binding.pry # ターミナルに「Review.create(review_params)」を入力する
    if @review_new.save!
      redirect_to reviews_path#indexのパス
    else
      render :index
    end
  end

  private
  def admin_ad_mem_message_params #updateのパラメータ
    params.require(:message).permit(:member_id, :admin_id, :am_message_title, :am_message_item, :am_message_body, :am_message_reply)
  end

end


・・・

  def index
    # 送られたユーザーでないと表示できないように
    if current_member.id.to_i == params[:id].to_i
      @member = member.find_by(id: params[:id])
　　　 # messageをしているユーザーのidを配列で取得その後に自分のは削除。これで一覧でどのユーザーに対してのDMかを表示させる
      @message_member_ids = Message.where(admin_id: @member.id).or(Message.where(member_id: @member.id)).distinct.pluck(:member_id)
      @message_member_ids.delete(@member.id)
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
  def roomshow
    if current_member.id.to_i == params[:member_id].to_i
      @admin_id = params[:admin_id]
      @messages = Message.where(member_id: params[:member_id],admin_id: @admin_id).or(Message.where(member_id: params[:admin_id],admin_id: params[:member_id])).order(created_at: :asc)
      unread_messages = Message.where(admin_opentime: nil,admin_id: current_member.id)
      unread_messages.each do |unread_message|
        unread_message.admin_opentime = Date.today.to_time
        unread_message.save
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  def create
    if current_member.id.to_i == params[:member_id].to_i
      message = Message.new(content: params[:content],member_id: params[:member_id],admin_id: params[:admin_id])
      if message.save
        flash[:notice] = "送信しました！"
        redirect_back(fallback_location: root_path)
      else
        redirect_to("/")
        flash[:alert] = "投稿できませんでした"
      end
    end
  end