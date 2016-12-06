class CreateConcerts < ActiveRecord::Migration
  def change
    create_table :concerts do |t|
      t.datetime :date
      t.integer :artist_id
      t.integer :venue_id
      t.string :notes
      t.integer :user_id

      t.timestamps

    end
  end
end
