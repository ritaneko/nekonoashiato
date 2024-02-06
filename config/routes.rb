Rails.application.routes.draw do
devise_for :users
devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }
  
resources :photos, only: [:new, :create, :index, :show, :destroy] do
  resource :favorite, only: [:create, :destroy]
  resources :photo_comments, only: [:create, :destroy]
end
resources :users, only: [:show, :edit, :update]
root to: "homes#top"
get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
