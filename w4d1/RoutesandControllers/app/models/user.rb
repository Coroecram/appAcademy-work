class User < ActiveRecord::Base
  validates :username, presence: true
  validates :username, uniqueness: true

  has_many(
    :contacts,
    class_name: "Contact",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :contact_shares,
    class_name: "ContactShare",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :shares,
    through: :contacts,
    source: :contact_shares
  )

  has_many(
    :contact_receivers,
    through: :shares,
    source: :user
  )

  has_many(
    :received_contacts,
    through: :contact_shares,
    source: :contact
  )

  has_many :comments, as: :commentable

end
