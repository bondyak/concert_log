class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :location
      t.string :notes
      
      t.timestamps

    end
  end
end
