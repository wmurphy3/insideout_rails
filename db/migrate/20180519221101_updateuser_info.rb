class UpdateuserInfo < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :city
    remove_column :users, :state

    add_column :users, :subscribed, :boolean, default: false

    add_column :user_profiles, :distance, :integer
  end
end
