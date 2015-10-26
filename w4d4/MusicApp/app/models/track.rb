class Track < ActiveRecord::Base

  validates :title, :album_id, presence: true
  #validates :title, uniqueness: { scope: album_id, allow_nil: true }

  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )

  has_one(
    :artist,
    through: :album,
    source: :artist
  )

end
