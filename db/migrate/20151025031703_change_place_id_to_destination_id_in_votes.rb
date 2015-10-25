class ChangePlaceIdToDestinationIdInVotes < ActiveRecord::Migration
  def change
    rename_column :votes, :place_id, :destination_id
  end
end
