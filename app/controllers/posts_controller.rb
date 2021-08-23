class PostsController < ApplicationController

# postsコントローラーのnewアクションやcreateアクションを実行する前にauthenticate_user!を読み込む
before_action :authenticate_user!

# showアクションとdestroyアクションが呼ばれる前に@postを読み込む
before_action :set_post, only: %i(show destroy)

def new
  @post = Post.new
  @post.photos.build
end

def create
  # newメソッドでインスタンスを作成
  @post = Post.new(post_params)
  if @post.photos.present?
    @post.save
    # redirect_toは指定したページに遷移する
    redirect_to root_path
    flash[:notice] = "投稿が保存されました"
  else
    redirect_to root_path
    flash[:alert] = "投稿に失敗しました"
  end
end

# postsコントローラーにindexアクションを作成
def index
  # orderは特定の順序で並べる場合に使う
  # created_at DESCとすることで最新の日時順に並ぶ
  # データ量N+1問題を解消するためにincludesメソッドを使う
  @posts = Post.limit(10).includes(:photos, :user).order('created_at DESC')
end

# postsコントローラーにshowアクションを作成
def show
end

# postsコントローラーにdestroyアクションを作成
def destroy
  if @post.user == current_user
    flash[:notice]="投稿が削除されました" if @post.destroy
  else
    flash[:alert]="投稿の削除に失敗しました"
  end
    redirect_to root_path
end

private

# paramsは送られてきたリクエスト情報をひとまとめにしたもの
# requireは受け取る値のキーを設定
# permitは変更を加えられるキーを設定
# mergeは2つのメソッドを統合するメソッド（誰が投稿したかという情報が必要なため、user_idの情報を統合しています）
  def post_params
    params.require(:post).permit(:caption, photos_attributes: [:image]).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end


end
