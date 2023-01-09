class Public::MembersController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
   before_action :authenticate_member!

  def show
    # マイページをクリックしたらprivateのcreate_room(管理者ー会員メッセージルーム)を作成する
    create_room
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def unsubscribe
  end

  def complete
  end
  
  def reviews
    @reviews = current_member.reviews.page(params[:page]).per(10).order("created_at DESC")
    @item = Item.find_by(id: params[:buy_item_id])
  end
  
  def update
    #editで編集後、マイページ(show)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @member = current_member
    if @member.update(members_information_params)#public/members#updateのパラメータ
      flash[:success] = "会員情報を更新しました"
      redirect_to members_my_page_path#public/members#show
    else
      render :edit
    end
  end

  def withdraw
    @member = current_member
    # is_deletedカラムをtrueに変更することにより削除フラグを立てる
    @member.update(is_deleted: true)
    reset_session
    # flash[:notice] = "退会処理が完了しました"
    redirect_to members_complete_path #public/members#complete
  end

  #投稿データのストロングパラメータ(セキュリティに関係する)
  #require/permitメソッド:DBの更新時、不要なパラメータを取り除く(必要なパラメータだけに絞り込む)
  #require(パラメータ群).permit(:変更可能なパラメータ名)
  #会員情報編集(edit)をした後、updateに遷移する
  private
  def members_information_params#updateのパラメータ
    params.require(:member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :company, :department, :postal_code, :address, :telephone_number, :email)
  end
  
  def create_room
    # 自身(会員)のroomがあるか判定
    @room = Room.find_by_member_id(current_member.id)
    # roomが存在しない場合、新規作成する
    if @room.nil?
      # 会員のIDと管理者のID(emailで判定)を取得する
      @room = Room.create(member_id: current_member.id, admin_id: Admin.find_by_email("a@a").id)
    end
  end

end
