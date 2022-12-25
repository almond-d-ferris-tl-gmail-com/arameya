class Public::SellItemsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_member!

  def index#商品一覧
    @member = current_member
    # ログインしている会員が販売している商品のみを表示させる
    #ページネーション
    @items = Item.where(member_id: current_member.id).includes(:member).page(params[:page]).per(10).order("created_at DESC")
    #会員が販売している商品数を取得
    @items_max = Item.where(member_id: current_member.id).count
  end

  def new#商品新規登録
    @member = current_member
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @item_new = Item.new
  end

  def show#同じアクション内で同じメソッドは使えない
    @member = current_member
    @item = Item.where(member_id: current_member.id).find(params[:id])
  end

  def edit
    @member = current_member
    @item = Item.find(params[:id])
  end
  
  def create
    @member = current_member
    #newで新規登録後、商品詳細ページ(show)に遷移する
    @item_new = Item.new(sell_item_params) #public/sell_items#updateのパラメータ
    @item_new.member_id = current_member.id # 商品登録者とログインユーザを紐づける
    # byebug
    if @item_new.save
      flash[:notice] ="商品新規登録が完了しました"
      redirect_to member_sell_item_path(@member.id, @item_new) #public/sell_items#show
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def update
    @member = current_member
    #editで編集後、商品詳細(show)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @item = Item.find(params[:id])
    if @item.update(sell_item_params)#updateのパラメータ
      redirect_to member_sell_item_path #public/sell_items#show
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to member_sell_items_path #public/sell_items#index
  end

  #投稿データのストロングパラメータ(セキュリティに関係する)
  #require/permitメソッド:DBの更新時、不要なパラメータを取り除く(必要なパラメータだけに絞り込む)
  #require(パラメータ群).permit(:変更可能なパラメータ名)
  #商品編集(edit)をした後、updateに遷移する
  private
  def sell_item_params#updateのパラメータ
    params.require(:item).permit(:image, :genre_id, :name, :used_condition, :introduction, :price, :postage, :sell_status)
  end

end
