class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_image, only: %i[show edit update destroy]

  def index
    @images = policy_scope(Image)
  end

  def show
    authorize @image
    @comment = Comment.new # We need it as the form to add a comment will be embeded in the show page
  end

  def new
    @image = Image.new
    authorize @image
  end

  def create
    @image = Image.new(image_params)
    @image.user = current_user
    authorize @image
  end

  def destroy
  end

  def edit
  end

  def update
  end

  private

  def set_image
    @image = Image.find(params[:id])
    authorize @image
  end

  def image_params
    params.require(:image).permit(:address, :options)
  end

end
