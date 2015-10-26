class Album < ActiveRecord::Base

  validates :title, :band_id, presence: true

  belongs_to(
    :artist,
    class_name: "Band",
    foreign_key: :band_id,
    primary_key: :id
  )

  has_many(
    :tracks,
    dependent: :destroy,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id
  )

end
