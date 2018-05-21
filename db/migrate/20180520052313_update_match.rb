class UpdateMatch < ActiveRecord::Migration[5.1]
  def change
    remove_column :matches, :next_step

    add_column :matches, :asker_next_step, :boolean, default: false
    add_column :matches, :accepter_next_step, :boolean, default: false
  end
end
