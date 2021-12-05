class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  def index
    @highlights = Article.order(created_at: :desc).first(3)

    current_page = (params[:page] || 1).to_i
    
    highlights_ids = @highlights.pluck(:id).join(',')

    if @highlights.empty?
       @articles = Article.order(created_at: :desc)
                          .page(current_page).per(2)
    else
        @articles = Article.order(created_at: :desc)
                          .where("id NOT IN(#{highlights_ids})")
                          .page(current_page).per(2)
    end
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:body)
  end

end
