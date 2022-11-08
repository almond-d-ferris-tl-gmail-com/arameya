class Public::BuyAddressesController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  # before_action :authenticate_member!

  def index#配送先登録/一覧
    #新規作成
    @address_new = Address.new
    #一覧表示
    @addresses = current_member.addresses.all
  end

  def edit#配送先編集
    @address = Address.find(params[:id])
  end

  def create
    #indexで新規登録後、配送先登録/一覧ページ(index)に遷移する
    @address_new = Address.new(buy_address_params)#updateのパラメータ
    @address_new.member_id = current_member.id
    if @address_new.save
      redirect_to buy_addresses_path#indexのパス
    else
      render :index
    end
  end

  def update
    #editで編集後、配送先登録/一覧(index)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @address = Address.find(params[:id])
    if @address.update(buy_address_params)#updateのパラメータ
      redirect_to buy_addresses_path #public/buy_addresses#index
    else
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to '/buy_addresses'#indexへのURL
  end
  
  private#editで編集可能部分
  def buy_address_params#updateのパラメータ
    params.require(:address).permit(:postal_code, :address, :name)
  end

end
