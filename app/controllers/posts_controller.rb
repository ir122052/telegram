class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :show]
  before_action :correct_user, only: [:destroy]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
   
  end

  def new
    if logged_in?
      @post = current_user.posts.build
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '投稿できませんでした。'
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_url
  end
  
  private
  
  def post_params
    params.require(:post).permit(:image, :content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
    redirect_to root_url
    end
  end
end
