class Public::PhotosController < ApplicationController

  def new
    @photo = Photo.new
    @photo.user_id = current_user.id
  end

  def create
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    tag_list = params[:photo][:tag_name].split('、')
    if @photo.save
      @photo.save_tags(tag_list)
       redirect_to photos_path(@photo), flash:{ notice:"投稿完了しました。" }
    else
      flash.now[:notice] = "投稿に失敗しました。"
      render :new
    end
  end

  def index
    @q = Photo.ransack(params[:q])
    if params[:q].present?
      @photos = @q.result(distinct: true)
    else
      @photos = Photo.all
    end
    @photos = @photos.page(params[:page]).per(10)
    @tag_list = Tag.all
  end

  def show
    @photo = Photo.find(params[:id])
    @photo_comment = PhotoComment.new
    @tag_list = @photo.tags.pluck(:tag_name).join('、')
    @photo_tags = @photo.tags
  end

  def edit
    @photo = Photo.find(params[:id])
    @tag_list = @photo.tags.pluck(:tag_name).join('、')
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @photos = @tag.photos.page(params[:page]).per(10)
  end

  def update
    @photo = Photo.find(params[:id])
    tag_list = params[:photo][:tag_name].split('、')
    if @photo.update(photo_params)
      if params[:photo][:status] == "公開"
        @old_relations = PhotoTag.where(photo_id: @photo.id)
        @old_relations.each do |relation|
          relation.delete
        end
       @photo.save_tag(tag_list)
        redirect_to photo_path(@photo.id), notice: '更新完了しました。'
      else
        redirect_to photos_path, notice: '下書きに登録しました。'
      end
    else
       render :edit
    end
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    redirect_to photos_path
  end

  private

  def photo_params
    params.require(:photo).permit(:user, :title, :image, :body, :tag_name)
  end
end
