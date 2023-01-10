class AddBeforePhotoToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :before_photo, :string
  end
end
