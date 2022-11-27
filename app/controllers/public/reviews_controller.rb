class Public::ReviewsController < ApplicationController
# ログインしていない場合、ヘッダーのボタンをクリックしたら強制的にログイン画面に移動する
  # except→ログイン画面への遷移を除外する→今回は除外するものがない
  before_action :authenticate_member!

  def new #レビュー・評価新規作成
    @review_new = Review.new
    # @order = Order.find(params[:id])
  end  
    
  def index #レビュー・評価一覧
    @reviews = current_member.reviews.all
  end

  def edit#レビュー・評価編集
    @review = Review.find(params[:id])
  end

  def create
    #newで新規登録後、一覧(index)に遷移する
    @review_new = Review.new(review_params)#updateのパラメータ
    @review_new.member_id = current_member.id
    binding.pry # ターミナルに「Review.create(review_params)」を入力する
    if @review_new.save!
      redirect_to reviews_path#indexのパス
    else
      render :index
    end
  end

  def update
    #editで編集後、一覧(index)に遷移する
    #@の変数は↑のeditに合わせているのではなく、render(失敗)したときの遷移先がedit画面なので、
    #そちらで使用されている@edit~と合わせる必要があり、結果的に↑と同じ変数名になる
    @review = Review.find(params[:id])
    if @review.update(review_params)#updateのパラメータ
      redirect_to reviews_path #public/reviews#index
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to '/reviews' #indexへのURL
  end
  
  private#editで編集可能部分
  def review_params #updateのパラメータ
    params.require(:review).permit(:review_title, :review_body, :star)
  end

end
