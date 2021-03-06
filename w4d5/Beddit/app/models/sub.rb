class Sub < ActiveRecord::Base

  validates :title,
            :description,
            :moderator_id,
            presence: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id

  has_many :posts, dependent: :destroy



end
