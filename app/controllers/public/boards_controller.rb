class Public::BoardsController < ApplicationController
 before_action :set_board, only: [:edit, :update, :destroy]
  
 def index
  @boards = Board.all.includes(:user).order(created_at: :desc)
 end
 
 def new
   @board = Board.new
 end
 
 def create
   @board = current_user.boards.build(board_params)
   if @board.save
    redirect_to boards_path
   else
    render :new
   end
 end
 
 def show
   @board = Board.find(params[:id])
   @post = Post.new
   @posts = @board.posts.includes(:user).order(created_at: :desc)
 end
 
 def edit; end
 
 def update
  if @board.update(board_params)
   redirect_to @board
  else
   render :edit
  end
 end
 
 def destroy
  @board.destroy!
  redirect_to boards_path
 end
 
 private
 
 def board_params
   params.require(:board).permit(:title, :body)
 end
 
 def set_board
  @board = current_user.boards.find(params[:id])
 end
end
