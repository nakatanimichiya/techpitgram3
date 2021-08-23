class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 投稿一つに対して、いいねを1回にするバリデーション
  validates :user_id, uniqueness: {scope: :post_id}
end
