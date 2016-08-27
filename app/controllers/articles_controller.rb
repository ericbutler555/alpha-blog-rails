class ArticlesController < ApplicationController

  # execute the get_article method before these 4 actions (allows the app to know which article/id to act on):
  before_action :get_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  # GET /articles and /articles.json:
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  # GET /articles/new:
  def new
    @article = Article.new
  end

  # POST /articles and /articles.json:
  def create
    @article = Article.create(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Article was successfully created!"
      redirect_to article_path(@article)
    else
      render 'new' # execute the "new" method again
      # debugging option: to print form submissions in plain text, type-> `render plain: params[:article].inspect`
    end
  end

  # GET /articles/1 and /articles/1.json:
  def show
  end

  # GET /articles/1/edit:
  def edit
  end

  # PATCH/PUT /articles/1 and /articles/1.json:
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated!"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  # DELETE /articles/1 and /articles/1.json:
  def destroy
    @article.destroy
    flash[:success] = "Article was successfully deleted!"
    redirect_to articles_path
  end

  private

    def get_article
      # could also just add this line to each of the show, edit, update, and destroy methods, but this is more D.R.Y.
      @article = Article.find(params[:id])
    end

    # whitelist which parameters are allowed through form:
    def article_params
      params.require(:article).permit(:title, :body)
    end

    def require_same_user
      if current_user != @article.user
        flash[:danger] = "You can only edit or delete your own articles"
        redirect_to root_path
      end
    end

end
