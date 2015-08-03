class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.text :ip_address
      t.integer :poll_id

      t.timestamps null: false
    end
  end
end
