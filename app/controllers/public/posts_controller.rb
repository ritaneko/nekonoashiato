class Public::PostsController < ApplicationController
  def create
   post = current_user.posts.build(post_params)
   if post.save
     redirect_to board_path(post.board), success: t('defaults.message.created')
   else
     flash.now[:danger] = t('dafaults.message.not_created')
     redirect_to board_path(params[:board_id])
   end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body).merge(board_id: params[:board_id])
  end
end
