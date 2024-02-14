class PhotosController < ApplicationController
  
  def new
    @photo = Photo.new
    @photo = current_user.photos.new
  end
  
  def create
    @photo = current_user.photos.new(photo_params)
    tag_list = params[:photo][:tag_name].split(nil)
    if @photo.save
       @photo.save_tag(tag_list)
       redirect_to photos_path
    else
      flash.now[:alert] = '投稿に失敗しました'
      render :new
    end
  end

  def index
    @photos = Photo.all
    @tag_list = Tag.all
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = PhotoComment.new
    @photo_tags = @photo.tags
    if params[:search] != nil && params[:search] != ''
      search = params[:search]
      @tag_list = Tag.where("tag_name LIKE ?", "%#{search}%")
    else
      @tag_list = Tag.all
    end 
  end
  
  def edit
    @photo = Photo.find(params[:id])
    @tag_list = @photo.tags.pluck(:tag_name).join(nil)
  end
  
  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @photos = @tag.photos.all
  end
  
  def update
    photo = Photo.find(params[:id])
    tag_list = params[:photo][:tag_name].split(nil)
    if photo.update(photo_params)
       old_relations = PhotoTag.where(photo_id: @photo.id)
        old_relations.each do |relation|
        relation.delete
        end
        
       photo.save_tag(tag_list)
       redirect_to photo_path(@photo.id),notice: '投稿完了'
    else
        redirect_to photos_path, notice: '下書きに登録しました'
    end
  end
    
  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy
    redirect_to photos_path
  end
  
  private
  
  def photo_params
    params.require(:photo).permit(:title, :image, :body, :tag_name)
  end
end
