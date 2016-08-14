class ArticlesController < ApplicationController

  # execute the get_article method before these 4 actions (allows the app to know which article/id to act on):
  before_action :get_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render 'new' # execute the "new" method again
      # debugging option: to print form submissions in plain text, type-> `render plain: params[:article].inspect`
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private
    def get_article
      # could also just add this line to each of the show, edit, update, and destroy methods, but this is more D.R.Y.
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :body)
    end

end
