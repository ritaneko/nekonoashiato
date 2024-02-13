class PhotosController < ApplicationController
  
  def new
    @photo = Photo.new
  end
  
  def create
    @photo = current_user.photos.build(photo_params)
    tag_list = params[:photo][:tag_name].split(',')
    if @photo.save
      @photo.save_tag(tag_list)
      redirect_to photos_path(@photo), notice: "投稿完了"
    else
      render :new
    end
  end

  def index
    @photos = Photo.page(params[:page])
    @photo = Tag.all
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = PhotoComment.new
    @photo_tags = @photo.tags
  end
  
  def edit
    @photo = Photo.find(params[:id])
    @tag_list = @photo.tags.pluck(:tag_name).join(',')
  end
  
  def update
    @photo = Photo.find(params[:id])
    tag_list = params[:photo][:tag_name].split(',')
    if @photo.update(photo_params)
      if params[:photo][:status] == "公開"
       @old_relations = PhotoTag.where(photo_id: @photo.id)
        @old_relations.each do |relation|
        relation.delete
        end
       @photo.save_tag(tag_list)
       redirect_to photo_path(@photo.id),notice: '投稿完了'
      else
        redirect_to photos_path, notice: '下書きに登録しました'
      end
    else
       render :edit
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
