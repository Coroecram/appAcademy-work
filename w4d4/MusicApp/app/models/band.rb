class Band < ActiveRecord::Base

  validates :title, presence: true

  has_many(
    :albums,
    class_name: "Album",
    dependent: :destroy,
    foreign_key: :band_id,
    primary_key: :id
  )

  has_many(
    :songs,
    through: :albums,
    source: :tracks
  )


end
