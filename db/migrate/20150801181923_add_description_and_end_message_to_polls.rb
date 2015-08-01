class AddDescriptionAndEndMessageToPolls < ActiveRecord::Migration
  def change
    add_column :polls, :description, :text
    add_column :polls, :end_message, :text
  end
end
