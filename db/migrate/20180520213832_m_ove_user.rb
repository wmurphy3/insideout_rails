class MOveUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_profiles, :age
    remove_column :user_profiles, :description

    add_column :users, :age, :integer
    add_column :users, :description, :text
  end
end
