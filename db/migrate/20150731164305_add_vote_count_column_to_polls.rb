class AddVoteCountColumnToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :vote_count, :integer
  end
end
