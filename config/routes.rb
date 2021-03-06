Rails.application.routes.draw do
  get 'tags/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about", as: "about"
  get "/search" => "searchs#search"

  resources :books, only: [:new,:index,:show,:edit,:create,:destroy,:update] do
    resources :post_comments, only: [:create,:destroy]
    resource :favorites, only: [:create,:destroy]
  end

  resources :users, only: [:index,:show,:edit,:update] do
    member do
      get :follows, :followers
    end
    resource :relationships, only: [:create,:destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
