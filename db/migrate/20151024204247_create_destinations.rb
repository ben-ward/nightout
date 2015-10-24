class CreateDestinations < ActiveRecord::Migration
  def change
    create_table :destinations do |t|
      t.string :name
      t.integer :event_id
      t.integer :category_id
      t.float :latitude
      t.float :longitude
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :country
      t.string :postal

      t.timestamps null: false
    end
  end
end
