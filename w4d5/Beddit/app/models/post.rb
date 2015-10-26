class Post < ActiveRecord::Base

  validates :title,
        :author_id,
        :sub_id,
        presence: true

  belongs_to :sub

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id
  )




end
