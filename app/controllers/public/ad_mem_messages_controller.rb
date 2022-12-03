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
    @message = AdMemMessage.find(params[:id])
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
