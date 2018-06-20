class CreateMobileToken < ActiveRecord::Migration[5.1]
  def change
    create_table :mobile_tokens do |t|
      t.integer :user_id
      t.string :token
      t.string :device_type
      
      t.timestamps null: false
    end
  end
end
