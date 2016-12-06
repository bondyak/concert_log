class AddConcertCountToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :concerts_count, :integer
  end
end
