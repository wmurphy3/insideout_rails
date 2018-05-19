class CreateUserProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :user_profiles do |t|
      t.integer :user_id
      t.text    :description
      t.string  :favorite_movie
      t.string  :favorite_food
      t.string  :favorite_song
      t.string  :job_title
      t.text    :best_accomplishment
      t.string  :hobbies
      t.string  :last_school
      t.string  :social_media_link
      t.string  :snap_chat_name
      t.text    :profile_picture
      t.integer :interested_in
      t.integer :gender
    end
  end
end
