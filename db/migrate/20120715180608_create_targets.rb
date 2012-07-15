class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :user_id
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
