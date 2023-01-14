class AddCoordinatesToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :latitude, :float
    add_column :images, :longitude, :float
  end
end
