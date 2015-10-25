class AddDestinationIdToEvent < ActiveRecord::Migration
  def change
    add_column :events, :destination_id, :integer
  end
end
