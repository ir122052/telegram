class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    flash[:success] = 'いいねしました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    flash[:success] = 'いいねを解除しました。'
    redirect_back(fallback_location: root_path)
  end
end
