class LikesController < ApplicationController

  # サインインしていない状態でいいねするのを防ぐ
  before_action :authenticate_user!

  # buildメソッドでインスタンスを作成
  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    if @like.save
      # いいねを押したら、リアルタイムでビューを反映させるためにフォーマットをJS形式でレスポンスを返すようにする
      respond_to :js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private
    def like_params
      params.permit(:post_id)
    end
end
