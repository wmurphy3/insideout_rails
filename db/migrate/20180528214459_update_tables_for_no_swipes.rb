class UpdateTablesForNoSwipes < ActiveRecord::Migration[5.1]
  def change
    drop_table :decline_matches
    remove_column :matches, :accepted
  end
end
