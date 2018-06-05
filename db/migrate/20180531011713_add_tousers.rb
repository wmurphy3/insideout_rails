class AddTousers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gender, :string
    add_column :users, :favorite_movie, :string
    add_column :users, :favorite_food, :string
    add_column :users, :favorite_song, :string
    add_column :users, :job_title, :string
    add_column :users, :hobbies, :string
    add_column :users, :school, :string
    add_column :users, :social_media_link, :string
    add_column :users, :snap_chat_name, :string
    add_column :users, :profile_picture, :text

    add_column :users, :allow_male, :boolean, default: false
    add_column :users, :allow_female, :boolean, default: false
    add_column :users, :allow_other, :boolean, default: false
  end
end
