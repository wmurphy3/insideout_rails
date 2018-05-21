class CreateDeclineMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :decline_matches do |t|
      t.integer :asker_id
      t.integer :accepter_id
      t.timestamps null: false
    end
  end
end
