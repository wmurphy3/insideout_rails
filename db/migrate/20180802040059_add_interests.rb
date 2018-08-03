class AddInterests < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :interests, :text

    remove_column :users, :favorite_food
    remove_column :users, :favorite_song
    remove_column :users, :favorite_movie
    remove_column :users, :hobbies
    remove_column :users, :social_media_link
    remove_column :users, :snap_chat_name
  end
end
