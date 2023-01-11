class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_image, only: %i[show edit update destroy]

  def index
    @images = policy_scope(Image)
  end

  def show
    authorize @image
  end

  def new
    @image = Image.new
    authorize @image
  end

  def create
    @image = Image.new(image_params)
    @image.user = current_user

    gen_image = @image.generate_image_variations
    base64 = Base64.encode64(gen_image).split("\n").join

    @image.after_photo.attach(data: "data:image/png;base64,#{[base64]}", filename: "after.jpg") # https://github.com/rootstrap/active-storage-base64
    authorize @image
    if @image.save
      redirect_to @image, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
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
    params.require(:image).permit(:before_photo, :address, options: [])
  end


end
