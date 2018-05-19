class CreateMacthes < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :asker_id
      t.integer :accepter_id
      t.boolean :accepted
      t.boolean :next_step
    end
  end
end
