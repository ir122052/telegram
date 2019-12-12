class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :edit, :update, :destroy, :likes_posts]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
      
      if @user.update(user_params)
        flash[:success] = 'プロフィールを変更しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'プロフィールを変更できませんでした。'
        render :edit
      end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = '退会しました。'
    redirect_to root_url
  end
  
  def likes_posts
    @user = User.find(params[:id])
    @likes_posts = @user.likes_posts.page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduce)
  end

  def correct_user
    @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
  end
end
