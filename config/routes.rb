Rails.application.routes.draw do
devise_for :users
root to: "homes#top"
get "home/about" => "homes#about", as: "about"

devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
  end
  
resources :photos, only: [:new, :create, :index, :show, :destroy] do
  resource :favorite, only: [:create, :destroy]
  resources :photo_comments, only: [:create, :destroy]
end
resources :tags do
  get 'photos', to: 'photos#search'
end
resources :users, only: [:show, :edit, :update]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
