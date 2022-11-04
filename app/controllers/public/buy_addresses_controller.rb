class Public::BuyAddressesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_customer!

  def index#配送先登録/一覧
    #新規作成
    @address = Address.new
    #一覧表示
    @index_public_address = current_customer.addresses.all
  end

  def edit#配送先編集
    @edit_public_address = Address.find(params[:id])
  end

  def create
    #indexで新規登録後、配送先登録/一覧ページ(index)に遷移する
    @address = Address.new(address_params)#updateのパラメータ
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path#indexのパス
    else
      render :index
    end
  end

  def update
    #editで編集後、配送先登録/一覧(index)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @edit_public_address = Address.find(params[:id])
    if @edit_public_address.update(address_params)#updateのパラメータ
      redirect_to addresses_path#index
    else
      render :edit
    end
  end

  def destroy
    @destroy_public_address = Address.find(params[:id])
    @destroy_public_address.destroy
    redirect_to '/addresses'#indexへのURL
  end
  
  private#editで編集可能部分
  def address_params#updateのパラメータ
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
