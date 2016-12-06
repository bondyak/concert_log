class AddConcertCountToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :concerts_count, :integer
  end
end
