class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :option_id
      t.integer :poll_id
      t.text :ip_address

      t.timestamps null: false
    end
  end
end
