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
    @comment = Comment.new # We need it as the form to add a comment will be embeded in the show page
  end

  def new
    @image = Image.new
    authorize @image
  end

  def create
    @image = Image.new(image_params)
    @image.user = current_user

    # save our before photo
    before_photo_data = URI.parse(@image.before_photo_base_url).open
    @image.before_photo.attach(io: before_photo_data, filename: "before_photo_#{@image_id}.jpg")

    gen_image = @image.generate_image_variations
    # base64 = Base64.encode64(gen_image).split("\n").join # This is for text to image functionality not currently in use
    blob = Base64.decode64(gen_image)
    image = MiniMagick::Image.read(blob)
    image.write("image.jpg")
    @image.after_photo.attach(io: File.open("image.jpg"), filename: "after_photo_#{@image_id}.jpg", content_type: "image/jpeg")
    # @image.after_photo.attach(data: "data:image/png;base64,#{[base64]}", filename: "after.jpg") # This is for text to image functionality not currently in use # https://github.com/rootstrap/active-storage-base64
    authorize @image
    if @image.save
      redirect_to image_path('/images/new'), status: :see_other
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
    params.require(:image).permit(:before_photo_base_url, :address, options: [])
  end

end
