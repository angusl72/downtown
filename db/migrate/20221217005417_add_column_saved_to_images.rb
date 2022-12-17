class AddColumnSavedToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :saved, :boolean, default: false
  end
end
