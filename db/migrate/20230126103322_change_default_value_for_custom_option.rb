class ChangeDefaultValueForCustomOption < ActiveRecord::Migration[7.0]
  def change
    change_column_default :images, :custom_option, ""
  end
end
