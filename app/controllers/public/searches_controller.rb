class Public::SearchesController < ApplicationController
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    if @model == 'genre'
      @records = Genre.search_for(@content, @method)
    else
      @records = Item.search_for(@content, @method)
    end
  end
end
