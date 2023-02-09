Rails.application.routes.draw do
  # get 'users/show'
  devise_for :users, :controllers => { registrations: 'users/registrations', sessions: 'users/sessions' }
  root to: "images#index"
  resources :images, except: %i[edit] do
    get '/page/:page', action: :index, on: :collection
    resources :comments, only: %i[new create]
    member do
      get :generated
      patch :generated, to: 'images#save_image'
    end
    resources :users do
      member do
        get :edit_profile_photo
        patch :update_profile_photo
      end
    end
  end
    resources :comments, only: :destroy
    resources :users, only: :show
end
# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# Defines the root path route ("/")
# root "articles#index"
