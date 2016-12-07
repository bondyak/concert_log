class Artist < ApplicationRecord
  # Direct associations

  has_many   :concerts

  # Indirect associations

  # Validations
  validates :name, :presence => true

end
