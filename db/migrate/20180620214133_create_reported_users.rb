class CreateReportedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :reported_users do |t|
      t.integer :user_id
      t.string  :reported_reason
      t.timestamps null: false
    end
  end
end
