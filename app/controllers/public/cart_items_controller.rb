class Public::CartItemsController < ApplicationController
  # ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_member!

  def index
    @cart_item = current_customer.cart_items#current_customer(1):cart_items(多)
    @total = 0
  end
  
  def destroy
    current_customer.cart_items.find(params[:id]).destroy
			flash[:notice] = "カート内の商品が削除されました"
      redirect_to '/cart_items'#public/cart_items#indexへのURL
  end

  def create
    @create_cart_item = CartItem.new(cart_item_params)#updateのパラメータ
    @create_cart_item.customer_id = current_customer.id#顧客idと現在ログインしている顧客idを結びつける
    #注文の追加(追加した商品がカート内に存在するかの判別)
		if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
		  #存在した場合
		  cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
		  #カート内の個数をフォームから送られた個数分追加する
		  cart_item.amount += params[:cart_item][:amount].to_i
		  cart_item.save
			flash[:notice] = "カート内の数量が変更されました"
			redirect_to cart_items_path#カートのpublic/cart_items#index
		#存在しなかった場合、カートモデルにレコードを新規作成する
		elsif @create_cart_item.save
			flash[:notice] = "カート内に商品が追加されました"
			redirect_to cart_items_path#カートのpublic/cart_items#index
		else
      #他のコントローラーのテンプレートを呼び出す"コントローラー名/アクション名"
      render template: "items/show"
		end
  end
  
  def update
    @update_cart_item = CartItem.find(params[:id])
    #byebug←エラーのチェックで使用(デフォルトでGemfaileに導入されている)
    #rails sを起動させて操作すると、controllerで記述した箇所で止まるのでターミナルで@~などを入力してデータが入っているかチェックできる
    #exitで終了する
    if @update_cart_item.update_attribute(:amount, params[:cart_item][:amount])#updateのパラメータ
      #update_attribute→updateの別名。値を1つだけ更新できる(今回はamount)
      # @update_cart_item.update(cart_item_params)←この記述で問題ないが、エラーが出るので↑に変更した
			flash[:notice] = "カート内の数量が変更されました"
      redirect_to cart_items_path#index
    else
      render :index
    end
  end

  private
  def cart_item_params#updateのパラメータ
    params.require(:cart_item).permit(:item_id, :amount)#permitメソッド:paramsで取得したパラメーターに対し保存の許可を行う
  end
end
