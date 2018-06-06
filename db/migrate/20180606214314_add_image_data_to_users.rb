class AddImageDataToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :profile_picture, :image_data
  end
end
