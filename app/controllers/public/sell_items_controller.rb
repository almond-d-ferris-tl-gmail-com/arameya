class Public::SellItemsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_admin!

  def index#商品一覧
    #ページネーション
    @items = Item.all.page(params[:page]).per(10)
  end

  def new#商品新規登録
    # Viewへ渡すためのインスタンス変数に空のModelオブジェクトを生成する。
    @item_new = Item.new
  end

  def show#同じアクション内で同じメソッドは使えない
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end
  
  def create
    #newで新規登録後、商品編集ページ(edit)に遷移する
    @item_new = Item.new(admin_item_params)#updateのパラメータ
    if @item_new.save
      flash[:notice] ="商品新規登録が完了しました"
      redirect_to admin_item_path(@item_new)#(admin/items#show)
    else
      render :new
    end
  end

  def update
    #editで編集後、商品詳細(show)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @item = Item.find(params[:id])
    if @item.update(admin_item_params)#updateのパラメータ
      redirect_to admin_item_path#admin/items#show
    else
      render :edit
    end
  end

  #投稿データのストロングパラメータ(セキュリティに関係する)
  #require/permitメソッド:DBの更新時、不要なパラメータを取り除く(必要なパラメータだけに絞り込む)
  #require(パラメータ群).permit(:変更可能なパラメータ名)
  #商品編集(edit)をした後、updateに遷移する
  private
  def admin_item_params#updateのパラメータ
    params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
