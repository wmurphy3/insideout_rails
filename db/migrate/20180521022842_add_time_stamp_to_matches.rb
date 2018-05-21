class AddTimeStampToMatches < ActiveRecord::Migration[5.1]
  def change
    add_column :matches, :created_at, :datetime, null: false
    add_column :matches, :updated_at, :datetime, null: false
  end
end
