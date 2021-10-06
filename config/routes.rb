Rails.application.routes.draw do
  resources :events do
    resource :entry, only: [:create, :update, :destroy]
  end
  devise_for :views
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
end
