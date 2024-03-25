class Admin::PhotoCommentsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!
  
  def index
    @photo_comments = PhotoComment.all
    @users = User.all
  end
  
  def destroy
    @photo_comment = PhotoComment.find(params[:id])
    @photo_comment.destroy
    redirect_to admin_photo_comments_path
  end
end
