class Public::PostsController < ApplicationController
  def create
    post = current_user.posts.build(post_params)
      if post.save
        redirect_to board_path(post.board), success: t('defaults.message.created', item: Post.model_name.human)
      else
        redirect_to board_path(post.board), danger: t('defaults.message.not_created', item: Post.model_name.human)
      end
  end
  
  private
  
  def post_params
    params_require(:post).permit(:body).merge(board_id: params[:board_id])
  end
      
end
