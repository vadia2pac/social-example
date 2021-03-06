# Entity posts
class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def self.from_users_followed_by(user)
    followed_user_ids = user.followed_user_ids
    where('user_id IN (:followed_user_ids) OR user_id = :user_id',
          followed_user_ids: followed_user_ids, user_id: user)
  end
end
