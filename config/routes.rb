Rails.application.routes.draw do
  devise_for :users,
  controllers:{registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/' => "pages#home"

  # トップページ
  root "posts#index"

  # プロフィールページ
  # usersコントローラーのshowアクション
  # idには1,2...
  # asはルーティングに名前を付けれる　user_pathというメソッドが生成
  get '/users/:id', to: 'users#show', as:'user'

  # postsコントローラーのnewアクション。投稿ページを表示するルーティング。
  # postsコントローラーのcreateアクション。投稿を作成するルーティング。
  # photosコントローラーのcreateアクション。投稿の写真を保存するルーティング。
  # 投稿一覧ページのルーティングを追加
  # postsコントローラーのindexアクションのルーティングの投稿一覧ページのルーティングとして設定
  # postsコントローラーのshowアクションのルーティングを投稿詳細ページのルーティングとして設定
  # postsコントローラーのdestroyアクションのルーティングを投稿削除機能のルーティングとして設定

  # get '/posts/new', to: 'posts#new'
  # post '/posts', to: 'posts#create'
  # post '/posts/:post_id/photos', to: 'photos#create', as: 'post_photos'

  # resourcesメソッドを使うと
  resources :posts, only: %i(new create index show destroy) do
    resources :photos, only: %i(create)

  # likesコントローラーのcreateアクション。いいねの情報を保存するルーティング。
  # likesコントローラーのdestroyアクション。いいねの情報を削除するルーティング
  resources :likes, only: %i(create destroy)

  # commentsコントローラーのcreateアクション。コメントの情報を保存するルーティング。
  # commentsコントローラーのdestroyアクション。コメントの情報を削除するルーティング。
  resources :comments, only: %i(create destroy)
  end
end
