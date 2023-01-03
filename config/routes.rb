Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root to: "images#index"
  resources :images, except: %i[edit] do
    resources :comments, only: %i[new create]
  end
  resources :comments, only: :destroy

end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# Defines the root path route ("/")
# root "articles#index"
