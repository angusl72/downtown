class AddCustomOptionToImages < ActiveRecord::Migration[7.0]
  def change
    add_column :images, :custom_option, :text, default: false
  end
end
