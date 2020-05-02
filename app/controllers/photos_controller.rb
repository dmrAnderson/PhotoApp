class PhotosController < ApplicationController
  before_action :set_photo, except: %i[index new create]

  def index
    @photos = Photo.all.order(updated_at: :desc)
    @photo = Photo.new
  end

  def show
  end

  def new
    @photo = Photo.new
    respond_to do |format|
      format.js
    end
  end

  def edit
  end

  def create
    @photo = Photo.new(photo_params)
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
    def set_photo
      @photo = Photo.find(params[:id])
    end

    def photo_params
      params.require(:photo).permit(:description)
    end
end
