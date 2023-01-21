class AddPrivateToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :private, :boolean, default: false
  end
end
