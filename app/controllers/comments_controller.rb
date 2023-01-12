class CommentsController < ApplicationController
  before_action :set_image, only: %i[new create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.image = @image
    @comment.user = current_user
    authorize @image
    if @comment.save!
      redirect_to image_path(@image)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def set_image
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
