class User < ApplicationRecord
  # アソシエーション（userモデルとpostモデルを繋ぐ）
  # has_manyは他のモデルとの間に「1対多」のつながりがあることを示す
  # 反対側にはbelongs_toを使う
  # dependent: :destroyをつけることでユーザーが削除されたら、そのユーザーに紐づく投稿を削除する
  has_many :posts, dependent: :destroy

  # userモデルとlikeモデルのアソシエーションの設定
  has_many :likes

  # userモデルとcommentモデルのアソシエーションの設定
  has_many :comments

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

        #  presence: trueは値が空ではないということ確かめるバリデーションです。
        #  また、length: { maximum: 50 }は値の文字数が最大50文字までということを表すバリデーションです。
  validates :name, presence: true, length: { maximum: 50 }

  # パスワードなしでプロフィール編集を可能にするメソッド
  def update_without_current_password(params, *options)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
