class Public::BoardsController < ApplicationController
 before_action :set_board, only: [:edit, :update, :destroy]
 def index
  @q = Board.ransack(params[:q])
  @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
 end
 
 def new
  @board = Board.new
 end
 
 def create
  @board = current_user.boards.build(board_params)
  if @board.save
   redirect_to boards_path, success: t('defaults.message.created', item: Board)
  else
   flash.now['danger'] = t('defaults.message.not_created', item: Board)
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
   redirect_to @board, success: t('defaults.message.updated')
  else
   flash.now[:danger] = t('defaults.message.not_updated')
   render :edit
  end
 end
 
 def destroy
  @board.destroy!
  redirect_to boards_path, success: t('defaults.message.deleted')
 end
 
 private
 
 def set_board
  @board = current_user.boards.find(params[:id])
 end
 
 def board_params
  params.require(:board).permit(:title, :body)
 end
end