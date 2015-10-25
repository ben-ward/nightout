class AddVicinityToDestinations < ActiveRecord::Migration
  def change
    add_column :destinations, :vicinity, :string
  end
end
