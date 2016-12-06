class AddConcertCountToArtists < ActiveRecord::Migration[5.0]
  def change
    add_column :artists, :concerts_count, :integer
  end
end
