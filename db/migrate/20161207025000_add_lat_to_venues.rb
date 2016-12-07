class AddLatToVenues < ActiveRecord::Migration[5.0]
  def change
    add_column :venues, :lat, :string
    add_column :venues, :lng, :string
  end
end
