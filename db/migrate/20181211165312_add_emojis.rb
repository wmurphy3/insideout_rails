class AddEmojis < ActiveRecord::Migration[5.1]
  def change
    execute "ALTER TABLE messages CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    execute "ALTER TABLE messages MODIFY message TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end
