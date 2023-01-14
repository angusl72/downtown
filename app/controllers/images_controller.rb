class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_image, only: %i[show edit update destroy]

  def index
    # Added .order here to show the newest ones first
    # also added a .limit, so we're not rendering too many images at once
    # TODO: also need to add some logic here that only shows SAVED photos from user
    @images = policy_scope(Image).order(created_at: :desc).limit(40)
  end

  def show
    authorize @image
    # @markers = @image.geocoded.map do |image|
    #   {
    #     lat: image.latitude,
    #     lng: image.longitude
    #   }
    # end
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
    # @image.after_photo.attach()
    @image.after_photo.attach(io: File.open("image.jpg"), filename: "after_photo_#{@image_id}.jpg", content_type: "image/jpeg")
    # raise
    # @image.after_photo.attach(data: "data:image/png;base64,#{[base64]}", filename: "after.jpg") # https://github.com/rootstrap/active-storage-base64
    authorize @image
    if @image.save
      redirect_to @image, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
    puts "----- BEFORE PHOTO ATTACHED: #{@image.before_photo.attached?} ----"
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
    params.require(:image).permit(:before_photo_base_url, :address, options: [])
  end

end
