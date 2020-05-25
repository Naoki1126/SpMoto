Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registraitions: 'admins/registraitions',
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registraitions: 'users/registraitions',
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 管理者側
  namespace :admins do
    resources :post_images, only: [:index, :show, :edit, :update, :destoroy]
    resources :events, only: [:index, :show, :edit, :update, :destoroy]
    resources :users, only: [:index, :show, :edit, :update, :destroy]
  end

  # 会員側
  get '/search' => 'search#search'
  root 'homes#top'
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    get '/destroy' => 'users#destroy_page'
    get '/follows' => 'users#follows'
    get '/followers' => 'users#followers'
  end
  # フォロー関連
  resources :relationships, only: [:create, :destroy]

  # 投稿関連
  resources :post_images do
    resource :post_image_comments, only: [:create, :destroy]
    resource :post_image_favorites, only: [:create, :destroy]
  end
  get '/post_image/hashtag/:name' => 'post_images#hashtag'
  get '/post_image/hashtag' => 'post_images#hashtag'
  # イベント関連
  resources :events do
    get '/destroy' => "events#destroy_page"
    resource :event_comments, only: [:create, :destroy]
    resource :event_participates, only: [:create, :destroy]
    get '/event_paricipates' => 'event_participates#index'
  end

  # チャット関連
  resources :rooms, only: [:index, :show, :create]

  # お知らせ関連
  resources :notifications, only: [:index, :destroy]

  # 地図
  get '/map_request', to: 'events#map', as: 'map_request'
end
