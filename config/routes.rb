Rails.application.routes.draw do

devise_for :users
devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

root to: "homes#top"
get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
