class Song < ApplicationRecord
  # Require there to be a title and it not be the same year
  validates :title, presence: true
  validates :title, uniqueness: {
  scope: %i[release_year artist_name],
  message: 'cannot be repeated by the same artist in the same year'
}
  # Released must be either true or false
  validates :released, inclusion: { in: [true, false] }
  # Requires an artist name
  validates :artist_name, presence: true
  # Released year must be entered, Also must not be in future
  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.today.year
    }
  end

  def released?
    released
  end
end
