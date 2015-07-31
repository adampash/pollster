class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.text :text
      t.integer :poll_id
      t.integer :vote_count

      t.timestamps null: false
    end
  end
end
