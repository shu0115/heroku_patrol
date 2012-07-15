class CreateAccessLogs < ActiveRecord::Migration
  def change
    create_table :access_logs do |t|
      t.integer :target_id
      t.integer :user_id
      t.text :response

      t.timestamps
    end
  end
end
