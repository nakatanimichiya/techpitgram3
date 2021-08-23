class Post < ApplicationRecord

  belongs_to :user

  # dependent: :destroyをつけることで、オブジェクトが削除される時に、関連づけられたオブジェクトのdestroyメソッドが実行される
  has_many :photos, dependent: :destroy

  # orderメソッドは関連づけられたオブジェクトに与えられる順序を指定する。descは降順でソートするという意味なので、新しい「いいね」順で取得する
  has_many :likes, ->{ order(created_at: :desc) }, dependent: :destroy

  # postモデルとcommentモデルのアソシエーションの設定
  has_many :comments, dependent: :destroy

  # accepts_nested_attributes_forメソッドは親から子を作成したり保存する時に使う
  # postモデルの子に値するphotoモデルを通して、Photosテーブルに写真を保存
  accepts_nested_attributes_for :photos

  def liked_by(current_user)
    # user_idとpost_idが一致するlikeを検索する
    Like.find_by(user_id: current_user.id, post_id: id)
  end
end
