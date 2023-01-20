class ChangePrivateName < ActiveRecord::Migration[7.0]
  def change
    rename_column :images, :private, :image_private
  end
end
