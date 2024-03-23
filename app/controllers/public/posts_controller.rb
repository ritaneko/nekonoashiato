class Public::PostsController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    post = current_user.posts.new(post_params)
    post.board_id = board.id
    post.save
    redirect_to board_path(board)
  end
  
  def destroy
    Post.find(params[:id]).destroy
    redirect_to board_path(params[:board_id])
  end
  
  private
  
  def post_params
    params.require(:post).permit(:body, :board_id)
  end
end
