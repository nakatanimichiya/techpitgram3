class Photo < ApplicationRecord

  belongs_to :post

  # 写真がなければ、投稿をできないようにする(バリデーション)
  # presence: trueは値が空ではないということを確かめるバリデーション
  validates :image, presence: true

  # Photoモデルのimageカラムと、ImageUploaderを紐付け
  mount_uploader :image, ImageUploader

end
