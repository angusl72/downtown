class ChangeSavedName < ActiveRecord::Migration[7.0]
  def change
    rename_column :images, :saved, :image_saved
  end
end
