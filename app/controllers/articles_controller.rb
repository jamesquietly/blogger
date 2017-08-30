class ArticlesController < ApplicationController
	include ArticlesHelper

  before_action :require_login, except: [:index, :show, :popular]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @article.increment(:view_count, by = 1)
    @article.save
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_name = current_user.username
    @article.save

    flash.notice = "Article '#{@article.title}' was created!"

    redirect_to article_path(@article)
  end

  def destroy
  	@article = Article.find(params[:id])
  	@article.destroy

  	flash.notice = "Article '#{@article.title}' was deleted!"

  	redirect_to articles_path
  end

  def edit
  	@article = Article.find(params[:id])
  end

  def update
  	@article = Article.find(params[:id])
  	@article.update(article_params)

  	flash.notice = "Article '#{@article.title}' was updated!"

  	redirect_to article_path(@article)
  end

  def popular
    @popular = Article.order("view_count DESC").limit(3)
  end
end