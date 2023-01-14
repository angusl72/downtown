class AddBeforePhotoUrlToImages < ActiveRecord::Migration[7.0]
  def change
    rename_column :images, :before_photo, :before_photo_base_url
  end
end
