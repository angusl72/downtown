class CreateImages < ActiveRecord::Migration[7.0]
  def change
    create_table :images do |t|
      t.string :address
      t.string :options, array: true, default: []
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
