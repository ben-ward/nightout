class AddVoteCountToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :vote_count, :integer, default: 0
  end
end
