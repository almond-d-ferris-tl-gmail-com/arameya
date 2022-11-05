class Admin::MembersController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_admin!
  
  def show #会員情報詳細画面
    @show_member = Member.find(params[:id])
  end

  def edit #会員情報編集画面
    @edit_member = Member.find(params[:id])
  end
  
  def update
    #editで編集後、会員詳細(show)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @edit_admin_member = Member.find(params[:id])
    if @edit_admin_member.update(admin_member_params)#updateのパラメータ
      flash[:success] = "会員情報を更新しました"
      redirect_to admin_member_path#admin/Members#show
    else
      render :edit
    end
  end
  
  #投稿データのストロングパラメータ(セキュリティに関係する)
  #require/permitメソッド:DBの更新時、不要なパラメータを取り除く(必要なパラメータだけに絞り込む)
  #require(パラメータ群).permit(:変更可能なパラメータ名)
  #会員情報編集(edit)をした後、updateに遷移する
  private
  def admin_member_params#updateのパラメータ
    params.require(:Member).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end
  
end
