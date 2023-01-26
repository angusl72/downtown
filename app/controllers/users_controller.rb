class UsersController < ApplicationController
  before_action :set_user
  def show
    authorize @user
  end

  def edit_profile_photo
    authorize @user
    @user = User.find(params[:id])
    @user = current_user
  end

  def update_profile_photo
    authorize @user
    @user = current_user
    if @user.update(user_params)
        redirect_to user_path(@user)
    else
        render :edit_profile_photo
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:profile_photo)
  end

end
