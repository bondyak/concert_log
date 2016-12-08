class Venue < ApplicationRecord
  # Direct associations

  has_many   :concerts

  # Indirect associations

  # Validations
  validates :name, :presence => true, :uniqueness => true
  validates :location, :presence => true

end
