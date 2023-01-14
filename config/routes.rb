Rails.application.routes.draw do
  # get 'users/show'
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: "images#index"
  resources :images, except: %i[edit] do
    resources :comments, only: %i[new create]
    collection do
      get :generated
    end
  end
  resources :comments, only: :destroy
  resources :users, only: :show
end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# Defines the root path route ("/")
# root "articles#index"
