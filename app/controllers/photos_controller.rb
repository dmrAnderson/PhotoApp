class PhotosController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :owner,              only:   %i[edit update destroy]

  def index
    @photos = Photo.all.order(id: :desc)
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = current_user.photos.build
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def create
    @photo = current_user.photos.build(photo_params)
    respond_to do |format|
      if @photo.save
        format.js
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.js
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @photo.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    def owner
      @photo = current_user.photos.find(params[:id])
      redirect_to :root if @photo.nil?
    end

    def photo_params
      params.require(:photo).permit(:description, :image)
    end
end
