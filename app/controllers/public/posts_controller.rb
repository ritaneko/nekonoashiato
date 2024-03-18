class Public::PostsController < ApplicationController
  def create
    post = current_user.posts.build(post_params)
    if post.save
      redirect_to board_path(params[:board_id]), success: t('defaults.message.created')
    else
      redirect_to board_path(params[:board_id]), danger: t('defaults.message.not_created')
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, :board_id).merge(board_id: params[:board_id])
  end
end
