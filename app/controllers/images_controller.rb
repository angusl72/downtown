class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_image, only: %i[show edit update destroy generated save_image]

  def index
    @images = policy_scope(Image).order(created_at: :desc).where(image_saved: true, image_private: false).page params[:page]
    # @images = policy_scope(Image).order(created_at: :desc).limit(40).where(image_saved: true, image_private: false)
  end

  def show
    @comment = Comment.new
    authorize @image

    # generate coordinates for our markers
    @images = Image.all # TODO: adjust to return closes 10-20 (@image.nearbys(20))
    @all_markers = @images.geocoded.map do |img|
      {
        lat: img.latitude,
        lng: img.longitude,
        info_window: render_to_string(partial: "popup", locals: { image: img }) # needs to be a string of HTML
      }
    end
    @image_marker = [{
      lat: @image.latitude,
      lng: @image.longitude,
      info_window: render_to_string(partial: "popup", locals: { image: @image })
    }]
  end

  def new
    @image = Image.new
    authorize @image
  end

  def create
    @image = Image.new(image_params)
    @image.user = current_user

    # save the image so that the before_photo is attached, otherwise it cannot be accessed.
    @image.save!

    gen_image = @image.generate_image_variations
    # base64 = Base64.encode64(gen_image).split("\n").join # This is for text to image functionality not currently in use
    blob = Base64.decode64(gen_image)
    image = MiniMagick::Image.read(blob)
    image.write("image.jpg")
    @image.after_photo.attach(io: File.open("image.jpg"), filename: "after_photo_#{@image_id}.jpg", content_type: "image/jpeg")
    # @image.after_photo.attach(data: "data:image/png;base64,#{[base64]}", filename: "after.jpg") # This is for text to image functionality not currently in use # https://github.com/rootstrap/active-storage-base64
    authorize @image
    if @image.save
      # redirect_to new_image_path, status: :see_other
      redirect_to generated_image_path(@image), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    puts "----- BEFORE PHOTO ATTACHED: #{@image.before_photo.attached?} ----"
  end

  def destroy
    authorize @image
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to action: :index, status: :see_other
  end

  def edit
  end

  def update
  end

  def generated
    authorize @image
  end

  def save_image
    authorize @image
    @image.image_private = image_params[:image_private]
    @image.image_saved = true
    @image.save
    redirect_to action: :index, status: :see_other
  end

  private

  def set_image
    @image = Image.find(params[:id])
    authorize @image
  end

  def image_params
    params.require(:image).permit(:before_photo_base_url, :address, :image_saved, :image_private, :custom_option, options: [])
  end

end
