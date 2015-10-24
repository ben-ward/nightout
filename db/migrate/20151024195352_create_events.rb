class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :owner
      t.datetime :time
      t.datetime :deadline

      t.timestamps null: false
    end
  end
end
