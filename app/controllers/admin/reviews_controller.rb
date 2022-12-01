class Admin::ReviewsController < ApplicationController
  def index
    # 会員の情報を取得
    @member = Member.find(params[:member_id])
    # 会員が投稿したレビューの情報を取得
    @reviews = @member.reviews
    # 会員名などを表示させないなら、「@reviews = Member.find(params[:member_id]).reviews」とまとめてOK
  end

  def show
    @member = Member.find(params[:member_id])
    @review = Review.find(params[:id])
    @order = Order.find(params[:id])
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_member_reviews_path(params[:member_id]) #admin/reviews#indexへのpath
  end

end
