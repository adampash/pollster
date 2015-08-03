class AddBallotIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :ballot_id, :integer
  end
end
