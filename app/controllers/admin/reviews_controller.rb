class Admin::ReviewsController < ApplicationController
  def index
    @review = Review.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
  end
end
