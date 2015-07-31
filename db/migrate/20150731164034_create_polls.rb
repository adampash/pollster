class CreatePolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text :title
      t.boolean :live
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
