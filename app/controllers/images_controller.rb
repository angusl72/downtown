class ImagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def update
  end
end
