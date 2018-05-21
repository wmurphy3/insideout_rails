class UpdateUserProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_profiles, :interested_in

    add_column :user_profiles, :allow_male, :boolean, default: false
    add_column :user_profiles, :allow_female, :boolean, default: false
    add_column :user_profiles, :allow_other, :boolean, default: false
    add_column :user_profiles, :age, :integer
  end
end
